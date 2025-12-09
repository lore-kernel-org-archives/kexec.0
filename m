Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A98AD3B7EA
	for <kexec@archiver.kernel.org>; Tue,  9 Dec 2025 00:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESQX9dCfw/miysNSHZ7blEL3o1iAiJaW52INcJ804D0=; b=IkwYzSgrfkavMwE8Vlb1RXynpI
	HYcHGSQfMIzFTtS8DFJr4/55GW6HaQJTpIzLWxfvw2gebnjmsfzDNl7CNJpsTrCeVmxHJ58+wmcKb
	/2dOoVlHqYBwP8TIX03whuPeMQ73vguUQJmnRdaWV48TGeQibbLDAiHYsbf0fNggwZr6bLJZoD+PA
	412HBK4fudUrqOM+KV4jdrLe7oo0BOIBAutYt9dw7vNhqjgYHZZ6163B48i4zAibzqrDmOV/u/Hhb
	mcvl9nnqwRdORtykfqk9YvelY2L5uR/zlP7b1ry31Kp+vNVwRLiRPNR2v0Nf2HY9aes4tP6HWY0v5
	6JwVpKOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSlr3-0000000Dg56-1D0i;
	Tue, 09 Dec 2025 00:45:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSlr0-0000000Dg4c-1ok1
	for kexec@lists.infradead.org;
	Tue, 09 Dec 2025 00:45:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765241118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESQX9dCfw/miysNSHZ7blEL3o1iAiJaW52INcJ804D0=;
	b=VZPp9dhbs2MQ56w45vjbmoUzkUcagXmrGoV0GOR0FIolzLu/govBHouyU/e8ClUBX7pW62
	3nnr0ZTApaRbZm0YYsFiI/anrxrakM5+2ec08uYz2PNFRaYWA0C+CjZkaWeoThG515kbUF
	M0MdYW7X4khdR3FYBSeStBTuS8uEhFY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-x2TS1rs4MUKXfXjVR40AjQ-1; Mon,
 08 Dec 2025 19:45:14 -0500
X-MC-Unique: x2TS1rs4MUKXfXjVR40AjQ-1
X-Mimecast-MFC-AGG-ID: x2TS1rs4MUKXfXjVR40AjQ_1765241113
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD5501956096;
	Tue,  9 Dec 2025 00:45:12 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AF061800451;
	Tue,  9 Dec 2025 00:45:10 +0000 (UTC)
Date: Tue, 9 Dec 2025 08:45:06 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
	Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required
 for kexec_load
Message-ID: <aTdxEvqY6Bcy7Wa1@MiWiFi-R3L-srv>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
 <5be9a0d7-f014-41a7-97a2-75a3ba23f1d9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5be9a0d7-f014-41a7-97a2-75a3ba23f1d9@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_164522_574535_4BC5B4DE 
X-CRM114-Status: GOOD (  42.38  )
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

On 12/04/25 at 05:48pm, Sourabh Jain wrote:
> Hello All,
> 
> I read this patch series, including the older versions, and this is what I
> think about the changes.
> 
> There are two main reasons I see for why this patch series is proposed
> (these were not mentioned in the cover letter or commit messages):
> 
> 1. Commit eb7622d908a09 ("kexec_file, riscv: print out debugging message
>    if required") and commit 6f8c1da071a4 ("kexec_file, arm64: print out
>    debugging message if required") moved some kexec-related debug prints to
>    kexec_dprintk instead of pr_debug or pr_notice.
> 
>    These commits made it easier to control the updated debug prints using
>    the -d option of kexec tool for kexec_file_load system call. But since
>    kexec_dprintk is not available for the kexec_load system call, those
> prints
>    are no longer available for kexec_load at all. So patch series try to
> bring
>    those logs for kexec_load system call.
> 
> 2. Patch 03/03 prints additional logs about the kexec image type, start,
>     head, and flags via kexec_dprintk for the kexec_load system call.
> 
> This is done by enabling the kexec_dprintk for kexec_load, so that logs
> from point 1 and the new logs from point 2 can be printed for kexec_load
> system call.

Thanks a lot for checking these, Soubarh

I thought Qiang had found some missing information and he needed them
when debugging kexec_load interface until I noticed he printed the
segments too in kernel. The segments has been printed in userspace
kexec-tools. After talking, Qiang said he doesn't encounter missing
information when debugging kexec_load interface, he added the segment
printing antoher time in kernel for comparing them with the segments
printed out in userspace kexec-tools.

Basically, when I use 'kexec -d' to debug kexec_load loading, no extra
information is needed. Adding printing in kernel will make them shown in
console, but not in term which is not in the same place.

Anyway, the patch 2 and 3 adding more debug printing to kexec_load
interface in kernel is gilding the lily, drawing legs on a snake.

Qiang,

If you stick to add it, please post patch 1 separately because it's a
code fixing patch which is great. And split patch 2 and 3 to another
patchset and post separately and seek people's ACK.

> 
> However, the patch series does not explain why these additional debug logs
> are needed for kexec_load. Since most of the work involved in loading
> kexec images through kexec_load happens in the kexec userspace tool, and
> the tool already provides enough logs to debug issues, the need for these
> extra kernel logs is not clear.
> 
> So adding the need for the additional debug logs in the cover letter or
> commit message is needed to decide whether it is worth adding the code
> change proposed in this patch series Also, I found it hard to map the commit
> message to the changes introduced in the commits. And finally If I review
> the patches only based on the code changes: 01/03 The commit message refers
> to kexec_dbg_print as kexec_core_dbg_print. 02/03 I think kexec_dbg_print
> should be set to false at the end of kimage_free, not at the start. 03/03
> There is duplication of debug logs for architectures that already print the
> same information. For example, arm64. - Sourabh Jain
> On 26/11/25 14:14, Qiang Ma wrote:
> > Overview:
> > =========
> > The commit a85ee18c7900 ("kexec_file: print out debugging message
> > if required") has added general code printing in kexec_file_load(),
> > but not in kexec_load().
> > Since kexec_load and kexec_file_load are not triggered simultaneously,
> > we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.
> > Next, we need to do some things in this patchset:
> > 1. rename kexec_file_dbg_print to kexec_dbg_print
> > 2. Add KEXEC_DEBUG
> > 3. Initialize kexec_dbg_print for kexec
> > 4. Fix uninitialized struct kimage *image pointer
> > 5. Set the reset of kexec_dbg_print to kimage_free
> > 
> > Testing:
> > =========
> > I did testing on x86_64, arm64 and loongarch. On x86_64, the printed messages
> > look like below:
> > 
> > unset CONFIG_KEXEC_FILE:
> > [   81.502374] kexec: kexec_load: type:0, start:0x23fff7700 head:0x10a4b9002 flags:0x3e0010
> > 
> > set CONFIG_KEXEC_FILE
> > [   36.774228] kexec_file: kernel: 0000000066c386c8 kernel_size: 0xd78400
> > [   36.821814] kexec-bzImage64: Loaded purgatory at 0x23fffb000
> > [   36.821826] kexec-bzImage64: Loaded boot_param, command line and misc at 0x23fff9000 bufsz=0x12d0 memsz=0x2000
> > [   36.821829] kexec-bzImage64: Loaded 64bit kernel at 0x23d400000 bufsz=0xd73400 memsz=0x2ab7000
> > [   36.821918] kexec-bzImage64: Loaded initrd at 0x23bd0b000 bufsz=0x16f40a8 memsz=0x16f40a8
> > [   36.821920] kexec-bzImage64: Final command line is: root=/dev/mapper/test-root crashkernel=auto rd.lvm.lv=test/root
> > [   36.821925] kexec-bzImage64: E820 memmap:
> > [   36.821926] kexec-bzImage64: 0000000000000000-000000000009ffff (1)
> > [   36.821928] kexec-bzImage64: 0000000000100000-0000000000811fff (1)
> > [   36.821930] kexec-bzImage64: 0000000000812000-0000000000812fff (2)
> > [   36.821931] kexec-bzImage64: 0000000000813000-00000000bee38fff (1)
> > [   36.821933] kexec-bzImage64: 00000000bee39000-00000000beec2fff (2)
> > [   36.821934] kexec-bzImage64: 00000000beec3000-00000000bf8ecfff (1)
> > [   36.821935] kexec-bzImage64: 00000000bf8ed000-00000000bfb6cfff (2)
> > [   36.821936] kexec-bzImage64: 00000000bfb6d000-00000000bfb7efff (3)
> > [   36.821937] kexec-bzImage64: 00000000bfb7f000-00000000bfbfefff (4)
> > [   36.821938] kexec-bzImage64: 00000000bfbff000-00000000bff7bfff (1)
> > [   36.821939] kexec-bzImage64: 00000000bff7c000-00000000bfffffff (2)
> > [   36.821940] kexec-bzImage64: 00000000feffc000-00000000feffffff (2)
> > [   36.821941] kexec-bzImage64: 00000000ffc00000-00000000ffffffff (2)
> > [   36.821942] kexec-bzImage64: 0000000100000000-000000023fffffff (1)
> > [   36.872348] kexec_file: nr_segments = 4
> > [   36.872356] kexec_file: segment[0]: buf=0x000000005314ece7 bufsz=0x4000 mem=0x23fffb000 memsz=0x5000
> > [   36.872370] kexec_file: segment[1]: buf=0x000000006e59b143 bufsz=0x12d0 mem=0x23fff9000 memsz=0x2000
> > [   36.872374] kexec_file: segment[2]: buf=0x00000000eb7b1fc3 bufsz=0xd73400 mem=0x23d400000 memsz=0x2ab7000
> > [   36.882172] kexec_file: segment[3]: buf=0x000000006af76441 bufsz=0x16f40a8 mem=0x23bd0b000 memsz=0x16f5000
> > [   36.889113] kexec_file: kexec_file_load: type:0, start:0x23fffb150 head:0x101a2e002 flags:0x8
> > 
> > Changes in v3:
> > ==========
> > - Rename kexec_core_dbg_print to kexec_dbg_print
> > - Remove unnecessary segments prints
> > - Remove patch "kexec_file: Fix the issue of mismatch between loop variable types"
> > 
> > Qiang Ma (3):
> >    kexec: Fix uninitialized struct kimage *image pointer
> >    kexec: add kexec flag to control debug printing
> >    kexec: print out debugging message if required for kexec_load
> > 
> >   include/linux/kexec.h      | 9 +++++----
> >   include/uapi/linux/kexec.h | 1 +
> >   kernel/kexec.c             | 8 +++++++-
> >   kernel/kexec_core.c        | 4 +++-
> >   kernel/kexec_file.c        | 4 +---
> >   5 files changed, 17 insertions(+), 9 deletions(-)
> > 
> 


