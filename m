Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from duke.felloff.net ([216.126.196.34])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fgv2C-0001Pd-1y
 for kexec@lists.infradead.org; Sat, 21 Jul 2018 16:47:10 +0000
Message-ID: <1AD2A76B46A10571107915DE89919D3B@felloff.net>
Subject: kexec support for plan9 on x86
Date: Sat, 21 Jul 2018 18:46:42 +0200
From: cinap_lenrek@felloff.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="upas-phqurfdcxavjghyqkvncqijeij"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.
--upas-phqurfdcxavjghyqkvncqijeij
Content-Disposition: inline
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

implemented support in kexec-tools to boot plan9 kernel last night
(see attachment).

this is very basic support. it loads the kernel and provides it
a memory map (from info->memory_range) in its config area and also
has a optional parameter to pass additional plan9.ini configuration.

but i have a couple of questions:

who's in charge?

is here interest in supporting other OS than linux such as plan9
in the official kexec-tools? or should i write my own plan9 loader
for linux using the kexec_load() syscall directly?

on uefi systems, the address of the RSDT is passed to the kernel
in the config area as theres no known region to search for it.
this is done in 9front by the bootloader (as we do not want to
call back into crappy uefi code from our kernel once virtual
memory and interrups are set up). but i'v not seen any of the
kexec modules implement such a thing. so where do i get that
information from? how does linux locate the acpi tables?

on a uefi systems, theres no cga text mode. when linear
framebuffer was already set up. we pass this information in
the config area (done by efi loader using the GOP). but i havnt
seen any kexec module to implement passing the framebuffer
configuration to the new kernel. so where do i get that
that information in linux? this is also needed for proper
multiboot support.

the 9front kernel supports multiboot specification, but your
multiboot loader expects all multiboot images to be ELF files.
as well. what are you THINKING? :-)

--
cinap
--upas-phqurfdcxavjghyqkvncqijeij
Content-Disposition: attachment; filename=kexec-plan9-x86.c
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

/*
 * kexec: Linux boots Plan9
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation (version 2 of the License).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <getopt.h>
#include <elf.h>
#include "../../kexec.h"
#include "../../kexec-elf.h"
#include "../../kexec-elf-boot.h"
#include "kexec-x86.h"
#include <arch/options.h>

#define PGROUND(x)	(((x)+0xfff) & ~0xfff)
#define CONFADDR	0x1200
#define BOOTLINELEN	64

static char confbuf[0x1000];
static char *conf = confbuf + (CONFADDR & 0xfff) + BOOTLINELEN;
static char *confend = &confbuf[sizeof(confbuf)];

#define HDR_MAGIC	0x00008000		/* header expansion */
#define	_MAGIC(f, b)	((f)|((((4*(b))+0)*(b))+7))
#define	I_MAGIC		_MAGIC(0, 11)		/* intel 386 */
#define	S_MAGIC		_MAGIC(HDR_MAGIC, 26)	/* amd64 */

struct aouthdr
{
	uint32_t	magic;		/* magic number */
	uint32_t	text;	 	/* size of text segment */
	uint32_t	data;	 	/* size of initialized data */
	uint32_t	bss;	  	/* size of uninitialized data */
	uint32_t	syms;	 	/* size of symbol table */
	uint32_t	entry;	 	/* entry point */
	uint32_t	spsz;		/* size of pc/sp offset table */
	uint32_t	pcsz;		/* size of pc/line number table */
};

static uint32_t
l2be(uint32_t l)
{
	unsigned char *cp;

	cp = (unsigned char*)&l;
	return cp[0]<<24 | cp[1]<<16 | cp[2]<<8 | cp[3];
}

int plan9_x86_probe(const char *buf, off_t len)
{
	struct aouthdr hdr;
	uint32_t magic, text, data, size;

	if(len < sizeof(hdr))
		return -1;
	memcpy(&hdr, buf, sizeof(hdr));

	magic = l2be(hdr.magic);
	text = l2be(hdr.text);
	data = l2be(hdr.data);

	switch(magic){
	default:
		return -1;
	case I_MAGIC:
	case S_MAGIC:
		break;
	}

	size = sizeof(hdr);
	if(magic & HDR_MAGIC)
		size += 8;
	size += text;
	if(size < text || size > len)
		return -1;
	size += data;
	if(size < data || size > len)
		return -1;

	return 0;
}

void plan9_x86_usage(void)
{
	printf("    --ini=FILE		Use FILE as plan9.ini\n");
	printf("    --append=STING	Append to boot parameters\n");
}

static int
e820conf(struct kexec_info *info)
{
	struct memory_range *r;
	int n;

	conf += snprintf(conf, confend-conf, "*e820=");
	r = info->memory_range;
	for(n = info->memory_ranges; n > 0; n--, r++){
		if(r->type != RANGE_RAM)
			continue;
		conf += snprintf(conf, confend-conf, "1 %#llx %#llx ", r->start, r->end+1);
		if(conf >= confend)
			break;
	}
	if(conf >= confend)
		return -1;
	*conf++ = '\n';
	return 0;
}

static int
optconf(int argc, char **argv)
{
	long opt;
	char *buf;
	off_t nbuf;

	/* See options.h -- add any more there, too. */
	static const struct option options[] = {
		KEXEC_ARCH_OPTIONS
		{ "ini",1, 0, OPT_MOD },
		{ "append",1, 0, OPT_CL },
		{ 0,0, 0, 0 },
	};
	static const char short_options[] = KEXEC_ARCH_OPT_STR "";

	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
		switch(opt) {
		case OPT_CL:
			conf += snprintf(conf, confend-conf, "%s\n", optarg);
			if(conf >= confend)
				return -1;
			break;
		case OPT_MOD:
			buf = slurp_file(optarg, &nbuf);
			if(buf == NULL)
				return -1;
			if(conf + nbuf >= confend)
				return -1;
			memmove(conf, buf, nbuf);
			conf += nbuf;
			break;
		}
	}
	return 0;
}

int plan9_x86_load(int argc, char **argv, const char *buf, off_t len,
	struct kexec_info *info)
{
	struct aouthdr hdr;
	struct entry32_regs regs32;
	uint32_t magic, entry, text, data, align;

	memcpy(&hdr, buf, sizeof(hdr));
	magic = l2be(hdr.magic);
	entry = l2be(hdr.entry);
	text = l2be(hdr.text);
	data = l2be(hdr.data);

	buf += sizeof(hdr);
	if(magic & HDR_MAGIC)
		buf += 8;

	entry &= ~0xF0000000;
	align = entry & 0xFFF;

	add_segment(info, buf-align, text+align, entry-align, text+align);
	add_segment(info, buf+text, data, PGROUND(entry + text), data);

	if(e820conf(info) < 0)
		return -1;
	if(optconf(argc, argv) < 0)
		return -1;
	if(conf >= confend)
		return -1;
	*conf = 0;

	add_segment(info, confbuf, sizeof(confbuf), CONFADDR&~0xFFF, sizeof(confbuf));

	/* Load the setup code */
	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size, 0, ULONG_MAX, 1, 0);
	
	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs32, sizeof(regs32));
	regs32.eip = entry;
	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs32, sizeof(regs32));
	return 0;
}

--upas-phqurfdcxavjghyqkvncqijeij
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--upas-phqurfdcxavjghyqkvncqijeij--

