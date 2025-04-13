Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA36DC3601E
	for <kexec@archiver.kernel.org>; Sun, 13 Apr 2025 08:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqFi7DTiIUrbGcISmc0jdmcPJMujJXlDGLlNJu8BBzQ=; b=CRn+j1ZyS+6LNKZjU80FvTZKNB
	KzfNtVkYPODSs65i3le6sgSntj1qMCK53dsXCmdHHDvoLn7hZHxSXZonllfR++D/aIHLleNEUHYfQ
	uHKx4bpK93ZhleXuv9QNoQ+4JfZc2WD/7z9oC/7uosaSB0tiFCxtnx3RwUfXUByy1tXngD1zznsq2
	s/PobnOqI61jOxsc0a2hwPMYLv1mKzyi4mJVeAW26+iart/N4oJFRNxXSq8PhJJuybOr4Q/ZwIQOb
	Eh5nEBe9XN8nBhUDkJQ3QrcjFwcOq4uYdASX6lSNRBAUyW8ihVlGRQ7erjNpXKazlbFjcf5M75fI7
	2ZrUhLWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3t5H-0000000GyNU-0INq;
	Sun, 13 Apr 2025 08:52:59 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3t5E-0000000GyN5-2qyc;
	Sun, 13 Apr 2025 08:52:57 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3913958ebf2so2998922f8f.3;
        Sun, 13 Apr 2025 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744534374; x=1745139174; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZqFi7DTiIUrbGcISmc0jdmcPJMujJXlDGLlNJu8BBzQ=;
        b=J0sbjRBoCoCZ2zJ+ZhQnPg8XViP5WU+6IfNbflzzIGKqZjMhJa8Uu3j+YPw7Fifoo4
         tJd2SV0LvN+JesbTfXsjRJn5U3wFdB4LB2Kp0aKmFLer9mvjU30bexAzmBgMRipVg7XF
         pELaHyOF3U8xllROHBkTFiVAEJpZh6MuC1BU2Eam3Kq9l1F7SYeD2xGixlSMBf2idjn3
         pG1MHyzXCJWgxQKu7eFzQI/c465RblgUAokGKvL77sm4Ljo8h7/xbkdHSrv2WrL3+Qea
         VzL9lLrTn28zI8K6OzusFY9Ajxkm/CFmBNWqXUDHTpE6s92C6RsEPsAun01UTDgIk5GE
         00iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744534374; x=1745139174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqFi7DTiIUrbGcISmc0jdmcPJMujJXlDGLlNJu8BBzQ=;
        b=ikRHuJuqd4tOosyANFheLowV3AeaVfpFluwbQQghnk7+hAuWObABUh4VXHA8Um6ecZ
         giR5vLsntJN2NatjUMg84jsHeNBCIk3sVbAPEkC4fdT1mu/D+rzvsFOk9hKDL/3cbo9g
         Ag76n4id+fKuhk6dgZr0EL+ULyhIApUqPA1s4g+r+0Yg4BU0bvJSR+JUmKmUtPNKFNUH
         rNL6FHxj5Lji58xpzfsXgKAOUAi9v49o1P5X0WFkPnUo5dcXIeFCgCrlsajdfVibH+Jm
         7q6vgAScvLXMa4pD06QIy5JYEO5CmS1MXnOhDIfB+d9bnPTthBAj3VN19NnboDmqQ1lv
         bKvw==
X-Forwarded-Encrypted: i=1; AJvYcCWnLlNmbrLE+LHvQw2gUlBY2GdSyLXtAFK0tzgqJpOA+vb6DpD7Xboi5VM2Gg2q01kSkv+36/T6YRx90gz5lCTn@lists.infradead.org
X-Gm-Message-State: AOJu0YwMYIVEBj+h6Ll8KU2ITu0VxTKYDJRpjkdLNLvYmcybjB3eDRMW
	UCWnTT4SKXZ8Vamjk5C0/AFh9fn36bYUD4RyXf3h/+p7X7XaTk1z
X-Gm-Gg: ASbGncvwi4ZOk+hdvAxf6Kq++jBIaeS6DuviCv3MI+9tOjKNY8b+9uzJ9BMQOjFDyZH
	sKM/ViDPnXzN5yYeV7q667GJ2oGyh+m/eAUW+hFBIebKiWRVJGfUozQSKwlsKUgfLbHbIO9w3je
	9ARsfIdHE8/UAohUjk5qlL4Acc3wM8dRjODGhSGwN1ASTs1kcl7+mmt02XfwkJdvNy/rHYHGl+T
	bWBdCPTMLu72Io4am7St4Uqbo6o7SFD5VNKfc66E5ISPHcYTsqpniwnsm4OilSVnjTk3sSMs1VZ
	HW2DzfjRcSA/GGZCyiyhdbEc2ZqbIcmFPb/loAT8rw==
X-Google-Smtp-Source: AGHT+IGknmarvcQPpRnWlyPOaX/s+TI0PihO9g8pQhbTqXGcRFvvo7r3+rVBtN5Uv5iXOVcsWC7aiQ==
X-Received: by 2002:a05:6000:4007:b0:39c:1404:3748 with SMTP id ffacd0b85a97d-39ea51f45b1mr6770486f8f.16.1744534374229;
        Sun, 13 Apr 2025 01:52:54 -0700 (PDT)
Received: from Red ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39eae979615sm7499956f8f.54.2025.04.13.01.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 01:52:53 -0700 (PDT)
Date: Sun, 13 Apr 2025 10:52:50 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	mripard@kernel.org, wens@csie.org, ebiederm@xmission.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <Z_t7YuzRS5p7_D7_@Red>
References: <20200407113454.GA457@Red>
 <20200407122243.GN25745@shell.armlinux.org.uk>
 <20200407130559.GB457@Red>
 <20200407132602.GO25745@shell.armlinux.org.uk>
 <20200407134849.GC457@Red>
 <20200407181740.GP25745@shell.armlinux.org.uk>
 <20200408084029.GA1859@Red>
 <20200408093320.GQ25745@shell.armlinux.org.uk>
 <20200408152412.GA3621@Red>
 <20200408161657.GT25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200408161657.GT25745@shell.armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_015256_724543_C0F193D9 
X-CRM114-Status: GOOD (  36.16  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Le Wed, Apr 08, 2020 at 05:16:57PM +0100, Russell King - ARM Linux admin a écrit :
> On Wed, Apr 08, 2020 at 05:24:12PM +0200, Corentin Labbe wrote:
> > On Wed, Apr 08, 2020 at 10:33:20AM +0100, Russell King - ARM Linux admin wrote:
> > > On Wed, Apr 08, 2020 at 10:40:29AM +0200, Corentin Labbe wrote:
> > > > This is the last boot:
> > > > ## Loading init Ramdisk from Legacy Image at 2a000000 ...
> > > >    Image Name:   
> > > >    Image Type:   ARM Linux RAMDisk Image (uncompressed)
> > > >    Data Size:    8031928 Bytes = 7.7 MiB
> > > >    Load Address: 00000000
> > > >    Entry Point:  00000000
> > > >    Verifying Checksum ... OK
> > > > ## Flattened Device Tree blob at 23000000
> > > >    Booting using the fdt blob at 0x23000000
> > > >    Loading Ramdisk to 29857000, end 29fffeb8 ... OK
> > > >    Loading Device Tree to 2984e000, end 29856fd1 ... OK
> > > > Starting kernel ...
> > > > ID:0x00000000 DT:0x2984E000
> > > > Uncompressing Linux... done, booting the kernel.
> > > > [...]
> > > > fake uboot stuff
> > > > [...]
> > > > DEBUG: bootz: run kexec with --debug --kexec-syscall --force --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 earlyprintk ip=dhcp'
> > > > Set DEBUG!
> > > > main:1417 OPT_KEXEC_SYSCALL
> > > > main:1422 OPT_KEXEC_SYSCALL_AUTO
> > > > arch_process_options:119
> > > > main:1500
> > > > main:1517 res=0 do_load=1
> > > > main:1519 res=0 do_kexec_file_syscall=0
> > > > my_load:713
> > > > Try gzip decompression.
> > > > kernel: 0xb6931008 kernel_size: 0x444fc8
> > > > get_memory_ranges:36
> > > > MEMORY RANGES
> > > > 0000000020000000-000000009fffffff (0)
> > > > zImage_arm_load:423
> > > > zImage header: 0x016f2818 0x00000000 0x00444fc8
> > > > zImage size 0x444fc8, file size 0x444fc8
> > > > zImage requires 0x00455fc8 bytes
> > > >   offset 0x00006738 tag 0x5a534c4b size 8
> > > > Decompressed kernel sizes:
> > > >  text+data 0x00b77958 bss 0x0003d428 total 0x00bb4d80
> > > > Resulting kernel space: 0x00fcd920
> > > > Kernel: address=0x20008000 size=0x00fcd920
> > > > Initrd: address=0x20fd6000 size=0x016a6b97
> > > > DT    : address=0x2267d000 size=0x00006043
> > > > kexec_load: entry = 0x20008000 flags = 0x280000
> > > > nr_segments = 3
> > > > segment[0].buf   = 0xb6931008
> > > > segment[0].bufsz = 0x444fcc
> > > > segment[0].mem   = 0x20008000
> > > > segment[0].memsz = 0x445000
> > > > segment[1].buf   = 0xb528a008
> > > > segment[1].bufsz = 0x16a6b97
> > > > segment[1].mem   = 0x20fd6000
> > > > segment[1].memsz = 0x16a7000
> > > > segment[2].buf   = 0x4ef88
> > > > segment[2].bufsz = 0x6043
> > > > segment[2].mem   = 0x2267d000
> > > > segment[2].memsz = 0x7000
> > > > main:1568 res=0[   32.098439] sun7i-dwmac 830000.ethernet eth0: Link is Down
> > > > main:1582 res=0 do_exec=1
> > > > [   32.113191] kexec_core: Starting new kernel
> > > > [   32.460412] Bye!
> > > > ID:0xFFFFFFFF DT:0x2267D000
> > > > C:0x200080C0-0x2044CFE0->0x20B80500-0x20FC5420
> > > > ID:0xFFFFFFFF DT:0x2267D000
> > > > Uncompressing Linux... done, booting the kernel.
> > > 
> > > Okay, that looks fine:
> > > - the DT is out of the way, so shouldn't be corrupted by the
> > >   decompression process.
> > > - the decompressor writes the kernel image to 0x20008000 to 0x20b7f958
> > >   which is clear of the decompressor itself (which relocated itself
> > >   to 0x20b80500).
> > > - the ID doesn't matter for DT booting purposes.
> > > 
> > > I see you've gone back to using your own dtb rather than one derived
> > > from the booting kernel. I strongly recommend against giving your own
> > > dtb to kexec as if the boot loader modifies the DTB when calling the
> > > first kernel (such as adding memory region information, adding MAC
> > > addresses, enabling or disabling various devices) those modifications
> > > will be lost if you supply your own DTB to kexec.
> > > 
> > > Please drop "--dtb /tmp/dtb".
> > > 
> > 
> > Thanks it works now.
> > 
> > With a working setup I diffed dtb and the one given by uboot and it seems the missing node for booting was /memory.
> 
> That is more or less expected - it seems kexec never adds the /memory
> nodes to the dtb.  I've no idea whether it should or should not be doing
> so, and is for others to thrash out the arguments for and against what
> should be modified and how.
> 
> The upshot of the existing kexec behaviour is you can't take a dtb from
> the kernel build and use it with kexec.
> 
> > For booting a different kernel, I fdtput the dtb (for memory and bootargs), and it works until it try to mount the roofs which it find corrupt.
> 
> rootfs or initrd supplied to kexec?
> 
> > Since the rootfs I get by the fakeuboot is a "uboot legacy image" (rootfs.cpio.gz modified by mkimage), I drop the first 64bytes but it seems not sufficiant. (even if file say it is a good rootfs.cpio.gz)
> > Or perhaps the kernel get an invalid initrd address.
> 
> Yep, the file given via --initrd or --ramdisk is loaded exactly as-is
> into memory, no parsing of the file is done.  Neither the kernel, nor
> kexec, does any u-boot parsing of the initrd/ramdisk file; they are
> not u-boot.
> 
> If you want to try giving the kernel a bit more space, you can try
> --image-size=$((0x01000000)) to see whether that affects the ramdisk
> image problem - if it does, it means we're still not properly
> calculating the space the kernel needs.
> 

Hello

Just to say that adding --image-size=128000000 lead to a working setup.

Thanks

