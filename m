Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fr-hpida-esg-02.alcatel-lucent.com ([135.245.210.21]
 helo=smtp-fr.alcatel-lucent.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZyxeX-0005nd-GV
 for kexec@lists.infradead.org; Wed, 18 Nov 2015 07:59:43 +0000
From: "HECKEL, Hans (Hans)" <hans.heckel@alcatel-lucent.com>
Subject: RE: Problem: crashkernel boots at 512MB address in RAM with kexec
 -l/-e but not with kexec -p
Date: Wed, 18 Nov 2015 07:59:05 +0000
Message-ID: <BAEDA261213CF64EAEFAC725AB01AEC386CE5FEB@FR712WXCHMBA11.zeu.alcatel-lucent.com>
References: <BAEDA261213CF64EAEFAC725AB01AEC386CE1201@FR712WXCHMBA09.zeu.alcatel-lucent.com>
 <20151116053525.GA17574@dhcppc13.redhat.com>
In-Reply-To: <20151116053525.GA17574@dhcppc13.redhat.com>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0738327616747262560=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

--===============0738327616747262560==
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0467_01D121DF.5FB731C0"

------=_NextPart_000_0467_01D121DF.5FB731C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Pratyush,
thanks a lot for looking into my issue.
How do I enable purgatory for the SHA-256 verification?
With respect to limiting the kernel RAM: it oopses if I give only the first
512MB to the production kernel and then 256MB to the crash kernel ("mem=512M
crashkernel=128M@512M"). See details below. Seems like the crash kernel must
be *part* of the system RAM. Using "mem=768M crashkernel=128M@512M" I have
the same behavior as in my original post.
Do the segments from the kexec debug output look correct to you? In the
kexec -l/-e case there are only 3 while in the -p case I have 4 segments.
Details are in my original post.
Any other idea as to what to investigate? How could I check for corruption
of the crash kernel?
Again, thanks a lot. Best regards, Hans


[...]
boot_prep_linux commandline=console=ttyS0,38400 earlyprintk=ttyS0
root=/dev/ram rdinit=/sbin/init rw mem=512M crashkernel=128M@512M
[...]

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
------------[ cut here ]------------
kernel BUG at
/vol/1830sdw/users/hheckel/maxbcm/linux-3.4-ng/mm/bootmem.c:351!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.4.91-wr5 #"maxbcm_V01.00.00")
PC is at mark_bootmem+0xd8/0xec
LR is at reserve_bootmem+0x2c/0x30
pc : [<c0737e08>]    lr : [<c0738290>]    psr: 600001d3
sp : c076ff18  ip : 00000001  fp : c076ff54
r10: c074d5a4  r9 : 00028000  r8 : c0752370
r7 : 00020000  r6 : 00020000  r5 : 00020000  r4 : c075235c
r3 : 00000000  r2 : 00000001  r1 : c0752370  r0 : c0752370
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 38c53c7d  Table: 00003000  DAC: fffffffd
Process swapper (pid: 0, stack limit = 0xc076e2f0)
Stack: (0xc076ff18 to 0xc0770000)
ff00:                                                       c076ff64
c076ff28
ff20: c0731f94 00000001 c076ff4c 20000000 c0785cb0 c0868900 c0785cb0
c074d5a4
ff40: 00000000 c074d5a4 c076ff64 c076ff58 c0738290 c0737d3c c076ffbc
c076ff68
ff60: c0729868 c0738270 c076ff80 c076ff88 20000000 00000000 ffffffff
ffffffff
ff80: 08000000 00000000 20000000 00000000 00000000 00000001 00000000
c074ecb8
ffa0: c0785be4 00007000 562f5842 00000000 c076fff4 c076ffc0 c0725620
c0728f88
ffc0: 00000000 00000000 00000000 00000000 00000000 c074ecbc 00000000
38c73c7d
ffe0: c0780308 c074ecb8 00000000 c076fff8 00008054 c0725598 00000000
00000000
[<c0737e08>] (mark_bootmem+0xd8/0xec) from [<c0738290>]
(reserve_bootmem+0x2c/0x30)
[<c0738290>] (reserve_bootmem+0x2c/0x30) from [<c0729868>]
(setup_arch+0x8ec/0x9e8)
[<c0729868>] (setup_arch+0x8ec/0x9e8) from [<c0725620>]
(start_kernel+0x94/0x3a4)
[<c0725620>] (start_kernel+0x94/0x3a4) from [<00008054>] (0x8054)
Code: e2404014 e2841014 e1580001 1affffd7 (e7f001f2)
---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Fatal exception



-----Original Message-----
From: Pratyush Anand [mailto:panand@redhat.com] 
Sent: Montag, 16. November 2015 06:35
To: HECKEL, Hans (Hans)
Cc: kexec@lists.infradead.org
Subject: Re: Problem: crashkernel boots at 512MB address in RAM with kexec
-l/-e but not with kexec -p

On 12/11/2015:01:33:18 PM, HECKEL, Hans (Hans) wrote:
> Dear kexec team,
> I hope it is okay to ask you as my public problem description has not 
> yielded any replies so far. My problem is posted here:
> http://unix.stackexchange.com/questions/237580/boot-rescue-kernel-at-h
> igh-me
> mory-address-using-kexec-on-arm
> and also copied below (without the formatting). Update: Same result 
> when using kernel 4.3 and kexec-tools 2.0.11.
> Any help is highly appreciated, and thanks for the work you are 
> putting into kexec!
> Best regards,
> Hans Heckel (Alcatel-Lucent, IP Routing and Transport)
> 
> 
> Summary: Crashkernel boots at 512MB address in RAM with kexec -l/-e 
> but not with kexec -p - why?
> 
> Embedded platform with Marvell Armada XP (MV78460) (ARMv7 with 4 
> cores) and 1GB of RAM.
> production kernel: customized Linux 3.4.91 rescue kernel: clean 
> kernel.org-Linux (4.2.3) (I am aware that it uses device trees but 
> that works fine by appending DTB to zImage) in user-space, I am using 
> the latest kexec-tools (2.0.10)
> 
> History: Using kexec -l (with ramdisk and command line params from 
> 3.4.91-kernel, and --atags) and kexec -e, the rescue kernel boots just 
> fine and seems to place itself in the beginning of RAM (according to 
> /proc/iomem) regardless of what is being set via --mem-min and 
> --mem-max. When reserving space in RAM using the boot-option 
> crashkernel, I have to use a high memory address because otherwise it
tells me the requested area is already in use.
> So we set crashkernel=128M@512M. The kernel does not boot with kexec -p.
> 
> Current status: I understand that relocatable kernels
> (CONFIG_AUTO_ZRELADDR=y) must reside within the top 128MB which is not 
> possible for us. So I have worked around the standard kernel 
> configuration and forced CONFIG_ARM_PATCH_PHYS_VIRT to no and 
> CONFIG_PHYS_OFFSET to 0x20000000. I had to add a Makefile.boot for the 
> machine where I set zreladdr-y := 0x20008000, params_phys-y := 
> 0x20000100, initrd_phys-y := 0x20800000. Now the kernel still boots 
> fine using kexec -l and kexec -e and according to --mem-min. I can see 
> it is placed at 512MB. However, configuring it with -p and causing a 
> panic, the console says "Loading crashdump kernel... Bye!" and remains
silent forever.
> 
> All files and everything is only located in RAM.
> 
> What could I be doing wrong? Should I worry about the decompression 
> errors (even in the good case)?
> 
> >From dmesg:
> Reserving 128MB of memory at 512MB for crashkernel (System RAM: 760MB)
> 
> root@host:~# cat /proc/iomem
> 00000000-3bff9fff : System RAM
>   00008000-00724f43 : Kernel code
>   0076e000-0087553f : Kernel data
>   20000000-27ffffff : Crash kernel
> (some RAM at the end is reserved for persistent storage, that's why it 
> doesn't add up to 1GB)
> 
> Successful case:
> 
> root@host:~# kexec -l -t zImage --command-line="console=ttyS0,38400
> earlyprintk=ttyS0 root=/dev/ram rdinit=/sbin/init rw irqpoll maxcpus=1 
> reset_devices" --atags --initrd=./initramfs.cpio.gz -d 
> --mem-min=0x20000000
> --mem-max=0x28000000 ./zImage_fixed_addr Try gzip decompression.
> Try LZMA decompression.
> lzma_decompress_file: read on ./zImage_fixed_addr of 65536 bytes 
> failed
> kernel: 0xb6c06008 kernel_size: 0x3db659
> kexec_load: entry = 0x20008000 flags = 0x280000 nr_segments = 3
> segment[0].buf   = 0x40e98
> segment[0].bufsz = 0x3f0
> segment[0].mem   = 0x20001000
> segment[0].memsz = 0x1000
> segment[1].buf   = 0xb6c06008
> segment[1].bufsz = 0x3db659
> segment[1].mem   = 0x20008000
> segment[1].memsz = 0x3dc000
> segment[2].buf   = 0xb5ade008
> segment[2].bufsz = 0x1127516
> segment[2].mem   = 0x20f6e000
> segment[2].memsz = 0x1128000
> root@host:~# kexec -e
> Starting new kernel
> Booting Linux on physical CPU 0x0
> ...
> 
> After boot:
> 
> root@vanilla:~# cat /proc/iomem
> 20000000-3fffffff : System RAM
>   20008000-206dd237 : Kernel code
>   20720000-2078f54f : Kernel data
> 
> Unsuccessful case:
> 
> root@host:~# kexec -p -t zImage --command-line="console=ttyS0,38400
> earlyprintk=ttyS0 root=/dev/ram rdinit=/sbin/init rw irqpoll maxcpus=1 
> reset_devices" --atags --initrd=./initramfs.cpio.gz -d 
> ./zImage_fixed_addr Try gzip decompression Try LZMA decompression.
> lzma_decompress_file: read on ./zImage_fixed_addr of 65536 bytes 
> failed
> kernel: 0xb6b69008 kernel_size: 0x3db659
> phys_offset: 0
> kernel symbol _stext vaddr =         c0008240
> page_offset is set to c0000000
> get_crash_notes_per_cpu: crash_notes addr = 10f525c, size = 1024 Elf 
> header: p_type = 4, p_offset = 0x10f525c p_paddr = 0x10f525c p_vaddr =
> 0x0 p_filesz = 0x400 p_memsz = 0x400
> get_crash_notes_per_cpu: crash_notes addr = 10ff25c, size = 1024 Elf 
> header: p_type = 4, p_offset = 0x10ff25c p_paddr = 0x10ff25c p_vaddr =
> 0x0 p_filesz = 0x400 p_memsz = 0x400
> get_crash_notes_per_cpu: crash_notes addr = 110925c, size = 1024 Elf 
> header: p_type = 4, p_offset = 0x110925c p_paddr = 0x110925c p_vaddr =
> 0x0 p_filesz = 0x400 p_memsz = 0x400
> get_crash_notes_per_cpu: crash_notes addr = 111325c, size = 1024 Elf 
> header: p_type = 4, p_offset = 0x111325c p_paddr = 0x111325c p_vaddr =
> 0x0 p_filesz = 0x400 p_memsz = 0x400
> vmcoreinfo header: p_type = 4, p_offset = 0x7f1330 p_paddr = 0x7f1330 
> p_vaddr = 0x0 p_filesz = 0x1000 p_memsz = 0x1000 Elf header: p_type = 
> 1, p_offset = 0x0 p_paddr = 0x0 p_vaddr = 0xc0000000 p_filesz = 
> 0x20000000 p_memsz = 0x20000000 Elf header: p_type = 1, p_offset = 
> 0x28000000 p_paddr = 0x28000000 p_vaddr =
> 0xe8000000 p_filesz = 0x13ffa000 p_memsz = 0x13ffa000
> elfcorehdr: 0x27f00000
> crashkernel: [0x20000000 - 0x27ffffff] (128M) memory range: [0 - 
> 0x1fffffff] (512M) memory range: [0x28000000 - 0x3bff9fff] (319M) 
> kernel command line: "console=ttyS0,38400 earlyprintk=ttyS0 
> root=/dev/ram rdinit=/sbin/init rw irqpoll maxcpus=1 reset_devices 
> elfcorehdr=0x27f00000 mem=130048K"
> kexec_load: entry = 0x20008000 flags = 0x280001 nr_segments = 4
> segment[0].buf   = 0x416e0
> segment[0].bufsz = 0x410
> segment[0].mem   = 0x20001000
> segment[0].memsz = 0x1000
> segment[1].buf   = 0xb6b69008
> segment[1].bufsz = 0x3db659
> segment[1].mem   = 0x20008000
> segment[1].memsz = 0x3dc000
> segment[2].buf   = 0xb5a41008
> segment[2].bufsz = 0x1127516
> segment[2].mem   = 0x20f6e000
> segment[2].memsz = 0x1128000
> segment[3].buf   = 0x412a0
> segment[3].bufsz = 0x400
> segment[3].mem   = 0x27f00000
> segment[3].memsz = 0x1000
> 
> <cause crash via SysRq>
> 
> Loading crashdump kernel...
> Bye!

Although not sure, it might happen that your first kernel is corrupting
crash kernel and so you do not see any print even with earlyprintk enabled.
[it seems you are not using purgatory for sha256 verification].

Can you please try to limit memory visible to first kernel(pass mem=512M to
1st kenrel command line) and see if it improves?

~Pratyush

------=_NextPart_000_0467_01D121DF.5FB731C0
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIP+DCCA7Ew
ggKZoAMCAQICEBErBTlXKN63QvT+VRPTt1EwDQYJKoZIhvcNAQEFBQAwQzEXMBUGA1UEChMOQWxj
YXRlbCBMdWNlbnQxKDAmBgNVBAMTH0FsY2F0ZWwgTHVjZW50IEludGVybmFsIFJvb3QgQ0EwHhcN
MDgxMTAzMTU0MTE2WhcNMjgxMTAzMTU0MTE2WjBDMRcwFQYDVQQKEw5BbGNhdGVsIEx1Y2VudDEo
MCYGA1UEAxMfQWxjYXRlbCBMdWNlbnQgSW50ZXJuYWwgUm9vdCBDQTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAL5IGBVth8afQdnpuLDI0Z37GgIcPWznOOzFJUV1gVbztqQ5CIxkVL4K
soAfLzc8LQHqNl2Nk3YbVBputIyCe2nzGsRjQeVt+HO2PV7h2YpMQlVd+XGsmpJ4fAP3A38wkTl6
tFPAYspyUFvjNON1J3BJE/2cuY7apvn9ZfSz99x7y4QBZh3hvm4g5Fn7mK04/q7K6O4Z8Y6zkSxG
ZFNyZ6NIuAPNCODZASqYnHiAgtEcCR4WPs6rj+Y8MU0q56ddwuIZ0qeP2ScHY0wVtnmqXzHyCzEQ
Eb2eJCsGpXFwUalVaxPUZEVoVDfjO+2ZN5gNJrGMTu7Mv9k1WG0LR3zZ1QsCAwEAAaOBoDCBnTAL
BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUB6yyWvZhiXxcfOvilycpaQyK
H/AwEAYJKwYBBAGCNxUBBAMCAQAwTAYDVR0gBEUwQzBBBgRVHSAAMDkwNwYIKwYBBQUHAgEWK2h0
dHA6Ly93d3cuYWxjYXRlbC1sdWNlbnQuY29tL1BLSS9jcC9jcC5odG0wDQYJKoZIhvcNAQEFBQAD
ggEBADBMWG3WQyC6+mBzuuFuCGqJAiC4v+TQ3ZErd5KKSRGh8dwjzK5L2C51wJPVe6EAjb59CEb2
p2aPKSkoMrCC8seBRM/bs23DMyna1Jr9Q5EZDrmRqBLJy3Cs8NFpa/cKb6SkegFHcB/vi+SYgSdR
BwoNE5+y6MRPXcEBadI/9W8Zlkk5sJ3w55e+i8OCNg/fDYAQuJPa+hD3/byWGxUgGSMNGQ/GS2st
NETAa5Z/88Sh9FHk2BtrxSz7jPtekKhjsidD2ANJZTCyj9iRB+Nt9FEetNpcN6ke1FlepRbCsV10
I0y6weLwZ34h2GWbN9qEOSQV88NBA149a5ugJ/oCbHEwggTdMIIDxaADAgECAgoanQrOAAAAAAAG
MA0GCSqGSIb3DQEBBQUAMEMxFzAVBgNVBAoTDkFsY2F0ZWwgTHVjZW50MSgwJgYDVQQDEx9BbGNh
dGVsIEx1Y2VudCBJbnRlcm5hbCBSb290IENBMB4XDTA4MTEyMTIxNTcyOFoXDTE4MTEyMTIyMDcy
OFowgYUxEzARBgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZsdWNlbnQxFDASBgoJ
kiaJk/IsZAEZFgRuYTAyMRcwFQYDVQQKEw5BbGNhdGVsIEx1Y2VudDEnMCUGA1UEAxMeQWxjYXRl
bCBMdWNlbnQgSW50ZXJuYWwgU3ViIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
2Ocmcli3LbVU6TRh+JLMtquBr5/grS+gzfN5YL/lauFCHmDlF7kNQvxtDWqwNpOkzb97CwWcVsdf
kyWAiGzVWeRIrYGhK/xNPFRYXOKYXLGqxFWkltZkYpSRudHzjTneUC4EVdMXnREMu8FTC0CM38Vb
xMvQ+ygjEyicg2QT9lZHWkKP9kCI1818P+AmS7905t6kXR9Q2m1GjcCa0KqARPGX/xe2toQS+Vdi
UwDary1Enk8j19KFmvFg1bhY2mNSHgzN2AWnhsOi/EID1SalzBwHylByB/UbbEv2dZUsAdMuOtYt
Z/8dM1axS0d3fW7q7mAYV5uM42mYX9o1B/RzjwIDAQABo4IBjjCCAYowDwYDVR0TAQH/BAUwAwEB
/zAdBgNVHQ4EFgQU2exrvZZYIvfYpnfN/k2B77qXvRIwCwYDVR0PBAQDAgHGMBAGCSsGAQQBgjcV
AQQDAgEAMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMB8GA1UdIwQYMBaAFAesslr2YYl8XHzr
4pcnKWkMih/wMHgGA1UdHwRxMG8wbaBroGmGOWh0dHA6Ly9zZXJ2aWNlcy5zdXBwb3J0LmFsY2F0
ZWwtbHVjZW50LmNvbS9QS0kvcm9vdENBLmNybIYsaHR0cDovL3d3dy5hbGNhdGVsLWx1Y2VudC5j
b20vUEtJL3Jvb3RDQS5jcmwwgYIGCCsGAQUFBwEBBHYwdDA4BggrBgEFBQcwAoYsaHR0cDovL3d3
dy5hbGNhdGVsLWx1Y2VudC5jb20vUEtJL3Jvb3RDQS5jcnQwOAYIKwYBBQUHMAKGLGh0dHA6Ly93
d3cuYWxjYXRlbC1sdWNlbnQuY29tL1BLSS9yb290Q0EuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQCl
GxDp5Z1IDjIEz8VaTEWa8Q1OWUbXwsszdoNg5Gg3F1a2VFFVegmsrpt4axbESlgE6AT/rkUUiyjb
EhcUgY2OHdeKN5Gc7VOGh9D7SER9peARwSwx4NYRrsIaRXDrUswWAM6T6ilDUogjKYk3uK2zZ6Vy
7z3JewxVlhpeSsNPQSMoyNibKkYLRoh6rvz94vB0mvcT0uVx7xowPNoTOjjGRAk4J/MBaNOupvwf
RfPmwRetdnD6NC5x8aRkhr4ZNBjvYxFT8IJaeLk8piQYMPRDlzi7dlb9d6C5WuC0LRpomk2r3bd6
/XpNOx2FyG18axeeASWtENgPvqEirM5MjwkCMIIHXjCCBkagAwIBAgIKbDljHwAAAADDfTANBgkq
hkiG9w0BAQUFADCBhTETMBEGCgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBmx1Y2Vu
dDEUMBIGCgmSJomT8ixkARkWBG5hMDIxFzAVBgNVBAoTDkFsY2F0ZWwgTHVjZW50MScwJQYDVQQD
Ex5BbGNhdGVsIEx1Y2VudCBJbnRlcm5hbCBTdWIgQ0EwHhcNMTUwMzI1MDc1MzAzWhcNMTcwMzI0
MDc1MzAzWjBBMRAwDgYDVQQDEwdoaGVja2VsMS0wKwYJKoZIhvcNAQkBFh5oYW5zLmhlY2tlbEBh
bGNhdGVsLWx1Y2VudC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCObSXQmoh5
r81A/lCCauoh3qqVdaqxriOUUpVnZ0olOtcPyipbeRwgGIK3Ry81mqoKKzRQB6x+Dw33bGaX0Afc
sUJNxtW+TqBNBSj1wYKsrYLvSUzegYCPuRwgo/iWbxv35yOnt+CJB/LWpBjEALTxokaqzLqT6Slz
HGwH3avgTyP2wiKoOAlkCNUudHn4vElvgWSqFc/Jx85fTeuTTvJDbeGs9xhuetYvY9bJBwsOYDNq
UjzBlGeZ2q2XMDe1QTAQFkBpWzUsUP/tml8PPwWRxIHUb1sDb04xpje5byLbBpJb9zSv1PrKgI/U
51gcmHGMN1hl11WF8i5ikNyVvbHbAgMBAAGjggQRMIIEDTA9BgkrBgEEAYI3FQcEMDAuBiYrBgEE
AYI3FQiFvcVZg+OxOYelgSqGv8NChZSYGYEL+eZMhP21WgIBZAIBBTAfBgNVHSUEGDAWBgorBgEE
AYI3CgMEBggrBgEFBQcDBDALBgNVHQ8EBAMCBaAwKQYJKwYBBAGCNxUKBBwwGjAMBgorBgEEAYI3
CgMEMAoGCCsGAQUFBwMEMEQGCSqGSIb3DQEJDwQ3MDUwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3
DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNVHQ4EFgQUVPOh+DETPARGStLxk5dYajRN
RwMwHwYDVR0jBBgwFoAU2exrvZZYIvfYpnfN/k2B77qXvRIwggFcBgNVHR8EggFTMIIBTzCCAUug
ggFHoIIBQ4aB2WxkYXA6Ly8vQ049QWxjYXRlbCUyMEx1Y2VudCUyMEludGVybmFsJTIwU3ViJTIw
Q0EsQ049dXNuYXZzcGtpMDNwLENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1T
ZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWx1YWQsREM9bHVjZW50LERDPWNvbT9jZXJ0aWZp
Y2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSG
K2h0dHA6Ly93d3cuYWxjYXRlbC1sdWNlbnQuY29tL1BLSS9zdWJDQS5jcmyGOGh0dHA6Ly9zZXJ2
aWNlcy5zdXBwb3J0LmFsY2F0ZWwtbHVjZW50LmNvbS9QS0kvc3ViQ0EuY3JsMIIBYAYIKwYBBQUH
AQEEggFSMIIBTjCBzAYIKwYBBQUHMAKGgb9sZGFwOi8vL0NOPUFsY2F0ZWwlMjBMdWNlbnQlMjBJ
bnRlcm5hbCUyMFN1YiUyMENBLENOPUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1T
ZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWx1YWQsREM9bHVjZW50LERDPWNvbT9jQUNlcnRp
ZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA3BggrBgEFBQcw
AoYraHR0cDovL3d3dy5hbGNhdGVsLWx1Y2VudC5jb20vUEtJL3N1YkNBLmNydDBEBggrBgEFBQcw
AoY4aHR0cDovL3NlcnZpY2VzLnN1cHBvcnQuYWxjYXRlbC1sdWNlbnQuY29tL1BLSS9zdWJDQS5j
cnQwKQYDVR0RBCIwIIEeaGFucy5oZWNrZWxAYWxjYXRlbC1sdWNlbnQuY29tMA0GCSqGSIb3DQEB
BQUAA4IBAQATQuSrJCf/pBGvLG3NaNpkas8hPfk2c3UmG7yryoGUNGnHkClQzwQovHf8PUOjNhdx
jdFGq8SwdqKPnleUZ2um4a9+rVhf7mOyBEEAi5gUSvsjWyFeVd3byj7Gal3No5pJ/JkrCYyBtaWI
Z/ULIWQA5EDk5C25C8vXqYK3EGb29jtC9aX5aVodm3tkwl+vCkRKOg9uHolhKN+4S9gOjVzBTiEN
+NUtMtVtX+MlBWf3fSRtgDRQtbVa4awBdu6oMyixR/Ormrhy4fPZ/SgMFgsZtfVCqSF+8jYSSr/s
L6pjQGZbs6hQyrYJQQW1uFIh0bDLpMngxdWWEcz04bylgaxCMYIEKTCCBCUCAQEwgZQwgYUxEzAR
BgoJkiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZsdWNlbnQxFDASBgoJkiaJk/IsZAEZ
FgRuYTAyMRcwFQYDVQQKEw5BbGNhdGVsIEx1Y2VudDEnMCUGA1UEAxMeQWxjYXRlbCBMdWNlbnQg
SW50ZXJuYWwgU3ViIENBAgpsOWMfAAAAAMN9MAkGBSsOAwIaBQCgggJpMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE1MTExODA3NTkwM1owIwYJKoZIhvcNAQkEMRYE
FGMXpm2anTDSxUlmLD6kX8QPbDdpMIGlBgkrBgEEAYI3EAQxgZcwgZQwgYUxEzARBgoJkiaJk/Is
ZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZsdWNlbnQxFDASBgoJkiaJk/IsZAEZFgRuYTAyMRcw
FQYDVQQKEw5BbGNhdGVsIEx1Y2VudDEnMCUGA1UEAxMeQWxjYXRlbCBMdWNlbnQgSW50ZXJuYWwg
U3ViIENBAgpsOWMfAAAAAMN9MIGnBgsqhkiG9w0BCRACCzGBl6CBlDCBhTETMBEGCgmSJomT8ixk
ARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBmx1Y2VudDEUMBIGCgmSJomT8ixkARkWBG5hMDIxFzAV
BgNVBAoTDkFsY2F0ZWwgTHVjZW50MScwJQYDVQQDEx5BbGNhdGVsIEx1Y2VudCBJbnRlcm5hbCBT
dWIgQ0ECCmw5Yx8AAAAAw30wgbcGCSqGSIb3DQEJDzGBqTCBpjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwBwYFKw4DAgcw
DQYIKoZIhvcNAwICAUAwDQYIKoZIhvcNAwICASgwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCG
SAFlAwQCAjALBglghkgBZQMEAgEwCgYIKoZIhvcNAgUwDQYJKoZIhvcNAQEBBQAEggEAZ4BJux6x
hp6rHGLG2YVGs5DXl+lTbeyA6jjH1AWtJbM4nwWrbkEbZhEpPCFTsTEgcjZ8itOWYRQP+oRbz/EY
CrJM760EUoP+YH7x3026Fv69eP54+aIZPajiw0jaElxD6vN/3dAGGmhycqh9ea0BqgRyIGb2PoUI
8NY76mN65EiNGQltGVewict0Qcc8aKhLV9TPGRrKdfHIruBQ0IX7Hym5LI3asI33GcIxC0SbTtD9
igPqhpRkLdm3lnwIKUAmU5cMNk35rbZdBwUs+FVLAROxVi5rSKqjC5Ocrt16DigQu0dBY5RT/5ST
VUczfd+g8EnbTtON6fD2fbOKM1qmVgAAAAAAAA==

------=_NextPart_000_0467_01D121DF.5FB731C0--


--===============0738327616747262560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0738327616747262560==--

