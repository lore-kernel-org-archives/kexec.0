Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wr-out-0506.google.com ([64.233.184.238])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KNvgp-00025Y-Bx
	for kexec@lists.infradead.org; Tue, 29 Jul 2008 20:21:00 +0000
Received: by wr-out-0506.google.com with SMTP id 70so38073wra.22
	for <kexec@lists.infradead.org>; Tue, 29 Jul 2008 13:20:55 -0700 (PDT)
Message-ID: <802076b50807291320p6968ee3audd383b4e24825279@mail.gmail.com>
Date: Tue, 29 Jul 2008 21:20:55 +0100
From: "Kazek Kazik" <kazek3018@googlemail.com>
Subject: Kexec on SH4, STi7100 (ST40)
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello for all.

I try to run kexec on STi7100 processor. Unfortunately code from
kexec-tools-2.0.0-rc1.tar.gz is not working right.
I found in my kernel .config file:

#
# Memory management options
#
CONFIG_MMU=y
CONFIG_PAGE_OFFSET=0x80000000
CONFIG_MEMORY_START=0x04400000
CONFIG_MEMORY_SIZE=0x02400000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4

And I changed source code:
in kexec-sh.c file:
int get_memory_ranges(struct memory_range **range, int *ranges,
		      unsigned long kexec_flags)
{
	int memory_ranges;
	
	memory_ranges = 0;
	memory_range[memory_ranges].start = 0x84400000;
	memory_range[memory_ranges].end   = 0x84640000;
	memory_range[memory_ranges].type  = RANGE_RAM;
	memory_ranges++;
	*range = memory_range;
	*ranges = memory_ranges;
	return 0;
}
unsigned long get_empty_zero(char *s)
{
        char *env;

	env = getenv("KEXEC_EMPTY_ZERO");

	if(s)
	{
	  env = s;
	}
	else if(!env)
	{
		env = "0x84400000";
	}
	return 0x8fffffff & strtoul(env,(char **)NULL,0);
}

In kexec-zImage-sh.c file:
int zImage_sh_load(int argc, char **argv, const char *buf, off_t len,
	struct kexec_info *info)
{
        char *command_line;
	int opt;
	unsigned long empty_zero, area;
	unsigned char *param;
	unsigned long *paraml;

	static const struct option options[] = {
       	        KEXEC_ARCH_OPTIONS
		{0, 0, 0, 0},
	};

	static const char short_options[] = KEXEC_ARCH_OPT_STR "";

	command_line = 0;
	empty_zero = get_empty_zero(NULL);
	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
		switch (opt) {
		default:
			/* Ignore core options */
			if (opt < OPT_ARCH_MAX) {
				break;
			}
		case '?':
			usage();
			return -1;
		case OPT_APPEND:
			command_line = optarg;
			break;
		case OPT_EMPTYZERO:
			empty_zero = get_empty_zero(optarg);
			break;
		}
	}
	param = xmalloc(0x1000);
	memset(param, 0, 0x1000);
	area=locate_hole(info,len+0x1000,0,0,ULONG_MAX,INT_MAX);
	if (area == ULONG_MAX)
	{
		printf("Memory allocation error.");
	}
	//------------------
	printf("Debug info.\n");
	printf("Variable area --> 0x%08X\n", area);
	printf("Variable empty_zero --> 0x%08X\n", empty_zero);
	//------------------
	if (!command_line) {
		command_line = get_append();
	}
	strncpy(&param[256], command_line, strlen(command_line));
	paraml = (unsigned long *)param;
	printf("cmdline --> %s  <-- end of cmdline.\n", (char *)&param[256]);
	// paraml[0] = 1;  // readonly flag is set as default

	add_segment(info, param, 0x1000, area, 0x1000);
	add_segment(info, buf,   len,  (area + 0x1000), len);
	/* For now we don't have arguments to pass :( */
	info->entry = (void *)(area + 0x1000 + 0x1000);
	return 0;
}

I load new kernel in this way:
./kexec -l /tmp/usb/USB-Harddisk\ \(1-1\)/boot/zImage --type=zImage-sh
--append="console=ttyAS0,115200 root=/dev/sda1 mem=40m
bigphysarea=1280 coprocessor_mem=2m@0x04000000,2m@0x04200000"
--mem-min=84000000
and execute:
./kexec -e

This is what I get on tellnet:
Debug info.
Variable area --> 0x84400000
Variable empty_zero --> 0x84400000
cmdline --> console=ttyAS0,115200 root=/dev/sdb1 mem=40m
bigphysarea=1280 coprocessor_mem=2m@0x04000000,2m@0x04200000  <-- end
of cmdline.

And on console:
login[4354]: root login on 'pts/0'

Starting new kernel


Board: STb7100-mboard


U-Boot 1.1.2 (STLINUX_2_0p1) (May 30 2007 - 16:03:49)

DRAM:  32 MB
 write time out = 1, clock = 40
 write time out = 1, clock = 40
Flash: 16 MB
In:    serial
Out:   serial
Err:   serial
pll0 freq 531
pll1 freq 399
Net:   VFD_Driver Init
VFD_Controller Type : NEW Kathrein VFD
board_version = 0
Button_value = 7
Hit any key to stop autoboot:  1  0
## Booting image at a0040000 ...
   Image Name:   Linux-2.6.17.14_stm22_0037
   Image Type:   SuperH Linux Kernel Image (gzip compressed)
   Data Size:    1742761 Bytes =  1.7 MB
   Load Address: 84401000
   Entry Point:  84402000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel console=ttyAS0,115200 root=/dev/mtdblock3 mem=38m
bigphysarea=1280 coprocessor_mem=2m@0x04000000,2m@0x04200000 -
0x00000000 - 0 ...

Linux version 2.6.17.14_stm22_0037 (****@*****) (gcc version 4.1.1
(STMicroelectronics/Linux Base 4.1.1-21)) #125 PREEMPT Mon Jun 9
11:00:25 BST 2008
STMicroelectronics STb7100 Reference board initialisation
STb7100 version 3.x
Built 1 zonelists
Kernel command line: console=ttyAS0,115200 root=/dev/mtdblock3 mem=38m
bigphysarea=1280 coprocessor_mem=2m@0x04000000,2m@0x04200000
st-coprocessor: Failed to reserve memory at 0x04000000
st-coprocessor: Failed to reserve memory at 0x04200000
PID hash table entries: 256 (order: 8, 1024 bytes)
Using tmu for system timer
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29876k/38912k available (2897k kernel code, 9016k reserved,
364k data, 100k init)
PVR=04061100 CVR=30480000 PRR=00009100
I-cache : n_ways=2 n_sets=256 way_incr=8192
I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
D-cache : n_ways=2 n_sets=512 way_incr=16384
D-cache : entry_mask=0x00003fe0 alias_mask=0x00003000 n_aliases=4
Mount-cache hash table entries: 512
CPU: STb710x


I don't have any idea why it's reboot system instead run new kernel.
I will really thanks full for any help.

Szymon.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
