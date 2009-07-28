Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.249])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MVoNH-00075H-3x
	for kexec@lists.infradead.org; Tue, 28 Jul 2009 15:13:59 +0000
Received: by rv-out-0708.google.com with SMTP id c5so26069rvf.42
	for <kexec@lists.infradead.org>; Tue, 28 Jul 2009 08:13:53 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 28 Jul 2009 08:13:52 -0700
Message-ID: <110c8b2e0907280813n2bcf24daxdce75b07f35beee8@mail.gmail.com>
Subject: kexecing ELF image built by wraplinux or mkelf
From: Subodh Nijsure <nijsure.subodh@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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

I am trying to boot ELF image that is combined kernel + ramdisk. I
have tried to use wraplinux tool to wrap these two image but kexec
doesn't seem to boot the combined image.

To keep things simple I have decided to first just wrap bzImage

wraplinux -E --output vmlinux.wrap ./arch/i386/boot/bzImage

readelf -S vmlinux.wrap
There are 5 section headers, starting at offset 0x1f4098:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] setup             PROGBITS        00010000 000080 002a00 00 WAX  0   0 16
  [ 2] reloc             PROGBITS        00012a00 002a80 0005bc 00 WAX  0   0 16
  [ 3] kernel            PROGBITS        00100000 003040 1f1038 00   A  0   0 16
  [ 4] .shstrtab         STRTAB          00000000 1f4078 00001e 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

I am trying to load this image in my existing kernel using following
command line ( i instrumented the kexec a bit to print info structure
to see if kexec is reading the elf image correctly

kexec  --type=elf-x86 --args-elf --reuse-cmdline  ./vmlinux.wrap

kexec_load: entry = 0x17d8 flags = 0
nr_segments = 4
segment[0].buf   = 0x806f7b0
segment[0].bufsz = 7060
segment[0].mem   = 0x1000
segment[0].memsz = 9000
segment[1].buf   = 0x8076818
segment[1].bufsz = ec
segment[1].mem   = 0xa000
segment[1].memsz = 1000
segment[2].buf   = 0xb79f6088
segment[2].bufsz = 2fbc
segment[2].mem   = 0x10000
segment[2].memsz = 3000
segment[3].buf   = 0xb79f9048
segment[3].bufsz = 1f1038
segment[3].mem   = 0x100000
segment[3].memsz = 1f2000

I follow this my kexec -e and my machine "hangs".

Anybody has tried booting output of wraplinux using kexec? I have had
similar problems with mkelf-linux tool chain as well...

/Subodh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
