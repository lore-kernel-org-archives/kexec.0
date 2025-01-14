Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DAAC02180
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 01:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EjHfbTrazijVMIUCVhkudNwe2fjYYKc1mpZpcLc1Pys=; b=h8+33E7phL5AZAqsCZWQhzMnbf
	a/vALDkBxHATY3CO5/us522jGKw+UajOcJbNJCKeyosf+Sf+90mpQgmPi/JA5Q9Q3gGwyBcv8l12M
	QRvz38COgU+HztfpFrOr/DCOWaRmaiDduS0D/VL4trCSmWrl2yaUw3cb31DQX/4dWLCv6JkIu7DvG
	0jzmDbfboYY5NBEJJlsOJlJEWodCcL4X/GsID/67P7YRxE7aF5udcNhCndUyiTO7EChH3JSZOI7Hh
	pzgGT+T5IoL/ym+9fILcS8h6brmz1zqK6hk+G+jFIh+6lKDlL2sDeEAozkwo1FvZvWU1sAUCm00Kx
	aIB6nrnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXVkB-000000079EP-1jdA;
	Tue, 14 Jan 2025 01:29:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXVjx-000000079BT-0jMP
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 01:29:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736818145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EjHfbTrazijVMIUCVhkudNwe2fjYYKc1mpZpcLc1Pys=;
	b=Xhu+kzUYpVjso5WI3gjoRRSivWw7m4bodn9q3a8Hxe6n8K4XmQnKLSMCwnYBeUv+S1xf9j
	MVBFyUzKLC9U0h0QHTrIUybp275uJ3IkizSszx0YEq19joRGez2A8U9uAEyyRpaMvbikun
	6s4vEi4d2jODx1maVBZTxhytoU/Djyc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-jYkgOD5_O1C6xhEjibms2w-1; Mon,
 13 Jan 2025 20:29:00 -0500
X-MC-Unique: jYkgOD5_O1C6xhEjibms2w-1
X-Mimecast-MFC-AGG-ID: jYkgOD5_O1C6xhEjibms2w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73E981956087;
	Tue, 14 Jan 2025 01:28:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.144])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10F503003FD3;
	Tue, 14 Jan 2025 01:28:40 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Pingfan Liu <piliu@redhat.com>
Subject: [RFC] kexec: Use bpf to allow kexec to load PE format boot image
Date: Tue, 14 Jan 2025 09:28:25 +0800
Message-ID: <20250114012831.4883-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_172909_288346_18F0A59B 
X-CRM114-Status: GOOD (  20.29  )
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

Nowadays UEFI PE bootable image is more and more popular on the distribution.
But it is still an open issue to load that kind of image by kexec with IMA enabled

*** A brief review of the history ***
There are two categatories methods to handle this issue.
  -1. UEFI service emulator for UEFI stub
  -2. PE format parser

For the first one, I have tried a purgatory-style emulator [1]. But it
confronts the hardware scaling trouble.  For the second one, there are two
choices, one is to implement it inside the kernel, the other is inside the user
space.  Both zboot-format [2] and UKI-format [3] parsers are rejected due to
the concern that the variant format parsers will inflate the kernel code.  And
finally, we have these kinds of parsers in the user space 'kexec-tools'.


From the beginning, it has been perceived that the user space parser can not
satisfy the requirement of security-boot without an extra embeded signature.
This issue was suspended at that time. 

But now, more and more users expect the security feature and want the
kexec_file_load to guarantee it by IMA.  I tried to fix that issue by the extra
embeded signature method. But it is also disliked.

Enlighted by Philipp suggestion about implementing systemd-stub in bpf opcode in the discussion to [1],
I turn to the bpf and hope that parsers in bpf-program can resolve this issue. 

[1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
[2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
[3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
[4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-kernelfans@gmail.com/T/




*** Reflect the problem and a new proposal ***

The UEFI emulator is anchored at the UEFI spec. That will incur lots of work
due to various hardware support.  For example, to support TPM, the emulator
should implement PCI/I2C bus protocol.

But if the problem is confined to the original linux kernel boot protocol, it will be simple.
Only three things should be considered: the kernel image, the initrd and the command line.
If we can get them in a security way, we can tackle the problem.

The integrity of the file is ensured under the protection of the signature
envelope.  If the kexeced files are parsed in the user space, the envelopes are
opened and invalid.  So they should sink into the kernel space, be verified and
be manipulated there.  And to manipulate the various format file, we need
bpf-program, which know their format.

There are three parties in this solution
-1. The kexec-tools itself is protected by IMA, and it creates a bpf-map and
update UKI addon file names into the map. Later, the bpf-program will call
bpf-helper to pad these files into initrd

-2. The bpf-program is contained in a dedicated '.bpf' section in PE file. When
kexec_file_load a PE image, it extract the '.bpf' section and reflect it to the
user space through procfs. And kexec-tools starts the program.  By this way,
the bpf-program itself is free from tampering. 

The bpf-program completes two things:
	-1.parse the image format
	-2.call bpf kexec helpers to manipulate signed files

-3. The bpf helpers. There will be three helpers introduced.
The first one for the data exchange between the bpf-program and the kernel.
The second one for the decompressor.
The third one for the manipulation of the cpio



***  Overview of the design in Pseudocode ***


ThreadA: kexec thread which invokes kexec_file_load
ThreadB: the dedicated thread in kexec-tools to load bpf-prog
------
Diag 1. the interaction between bpf-prog loader and its executer


ThreadA						ThreadB

						wait on eventfd_A


expose bpf-prog through procfs
& signal eventfd_A
& wait on eventfd_B

						read the bpf-prog from procfs
						& initialize the bpf and install it to the fentry
						& signal eventfd_B
						& wait on eventfd_A again
						
fentry executes bpf-prog to parse image
& generate output for the next stop


-------------------
Diag 2. bpf-prog

SEC("fentry/kexec_pe_parser_hook")
int BPF_PROG(pe_parser, struct kimage *image, ...)
{

	buf = bpf_ringbuf_reserve(rb, size);
	buf_result = bpf_ringbuf_reserve(rb, res_sz);
	/* Ask kernel to copy the resource content to here */
	bpf_helper_carrier(resource_name, buf, size, in);
	
	/* Parse the format laying on buf */
	...
	/* call extra bpf-helpers */
	...
	
	/* Ask kernel to copy the resource content from here */
	bpf_helper_carrier(resource_name, buf_result, res_sz, out);

}

At present, bpf map functions provides the mechanism to exchange the data between the user space and bpf-prog.
But for bpf-prog and the kernel, there is no good choice. So I introduce a bpf helper function
	bpf_helper_carrier(resource_name, buf, size, in)

The above code implements the data exchange between the kernel and bpf-prog.
By this way, the data parsing process is not exposed to the user space any longer.



extra bpf-helpers:

	/* Decompress the compressed kernel image */
	bpf_helper_decompress(src, src_size, dst, dst_sz)
	
	/* 
	 * Verify the signature of @addon_filename, padding it to initrd's dir @dst_dir
	 */
	bpf_helper_supplement_initrd(dst_dir, addon_filename)

	Note: Due to the UEFI environment (such as edk2) only providing basic
        file operations for FAT filesystems, any UEFI-stub PE image (like systemd-stub)
        is restricted to these basic operation services.  As a result, the
        functionality of such bpf-kexec helpers is inherently limited.
	

*** Thoughts about the basic operation *** 

The basic operations have influence on the stability of bpf-kexec-helpers.

The kexec_file_load faces three kinds of elements: linux-kernel, initrd and cmdline.

For the kernel, on arm64 or riscv, in order to get the bootable image from the compressed data,
there should be a bpf-helper function as a wrapper of __decompress()

For initrd, systemd-sysext may require padding extra file into initrd

For cmdline, it may require some string trim or conjoin.

Overall, these user requirements are foreseeable and straightforward,
suggesting that bpf-kexec-helpers will likely remain stable without significant
changes.


Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
To: bpf@vger.kernel.org


