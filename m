Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085E0D116E6
	for <kexec@archiver.kernel.org>; Thu, 27 Nov 2025 01:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VEjh/6el/CR6HQF4+N/cfIx+FGtxrVKxbp2zGHhBXjw=; b=iFxY/cSJrr/9fOjkdA3bhPpCb/
	Iokofxfu+gwApOH+tjbEAvYXdvQAiq/pS9L/NR7x4kACy0wcwDczr1l+375/wIZzshwcVFyyEr8qC
	Bg9VD4eVRy4VNP0CSRMYYFf7J9i32DHjrE7MP7Dt8Ch/1dXq9Z/zuMyajqcOi+ZzDUbsWstRMB4N/
	zlqK/7ftvDvPoj3UR4tW+D16lIYAapN+4FfKLNs6QHeEEYZ3rV690XjRSDo8J6aMm2+hCyJjGGU85
	DROyFME7vbEUvNElcq/CIKEM6NaoyhwfvGRdfBxFcVM9PyzCDbIiVP+2HKfy+ULVmsaOdNqRhuicu
	AEvVJB1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOR6f-0000000FrWs-08ut;
	Thu, 27 Nov 2025 01:47:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOR6b-0000000FrWV-0Ns5
	for kexec@lists.infradead.org;
	Thu, 27 Nov 2025 01:47:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764208050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VEjh/6el/CR6HQF4+N/cfIx+FGtxrVKxbp2zGHhBXjw=;
	b=Hx0NVm9vK5keR+pyEOmQ5/tKYRO8Xm0UjlyiCD7Zu+9oQPAnZdl/BsKZDAGiaLjAOw89UQ
	yaNoqbJO0TAnHrwmsF3MxHo+gn529+WbrVCV1+Ura6Jeqoeg4ttxE/OQdAnLdpGipS2NHQ
	SMwS15KdFLKzO9WefHvhE441Kn6WITs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-CDWqeQVmMCCZMGGHX8HaRA-1; Wed,
 26 Nov 2025 20:47:26 -0500
X-MC-Unique: CDWqeQVmMCCZMGGHX8HaRA-1
X-Mimecast-MFC-AGG-ID: CDWqeQVmMCCZMGGHX8HaRA_1764208045
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81E8618002C3;
	Thu, 27 Nov 2025 01:47:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.107])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 540C718004A3;
	Thu, 27 Nov 2025 01:47:21 +0000 (UTC)
Date: Thu, 27 Nov 2025 09:47:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required
 for kexec_load
Message-ID: <aSetpjhZi3T1Mjhb@MiWiFi-R3L-srv>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126084427.3222212-1-maqianga@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_174733_208539_7D8CCABB 
X-CRM114-Status: GOOD (  20.28  )
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

Hi,

On 11/26/25 at 04:44pm, Qiang Ma wrote:
> Overview:
> =========
> The commit a85ee18c7900 ("kexec_file: print out debugging message
> if required") has added general code printing in kexec_file_load(),
> but not in kexec_load().
>     
> Since kexec_load and kexec_file_load are not triggered simultaneously,
> we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.

As I said in your last post, this is not needed at all, you just add a
not needed thing to kernel.

So NACK this patchset, unless you have reason to justify it. Sorry about
it.

Thanks
Baoquan

>     
> Next, we need to do some things in this patchset:
>     
> 1. rename kexec_file_dbg_print to kexec_dbg_print
> 2. Add KEXEC_DEBUG
> 3. Initialize kexec_dbg_print for kexec
> 4. Fix uninitialized struct kimage *image pointer 
> 5. Set the reset of kexec_dbg_print to kimage_free
> 
> Testing:
> =========
> I did testing on x86_64, arm64 and loongarch. On x86_64, the printed messages
> look like below:
> 
> unset CONFIG_KEXEC_FILE:
> [   81.502374] kexec: kexec_load: type:0, start:0x23fff7700 head:0x10a4b9002 flags:0x3e0010
> 
> set CONFIG_KEXEC_FILE
> [   36.774228] kexec_file: kernel: 0000000066c386c8 kernel_size: 0xd78400
> [   36.821814] kexec-bzImage64: Loaded purgatory at 0x23fffb000
> [   36.821826] kexec-bzImage64: Loaded boot_param, command line and misc at 0x23fff9000 bufsz=0x12d0 memsz=0x2000
> [   36.821829] kexec-bzImage64: Loaded 64bit kernel at 0x23d400000 bufsz=0xd73400 memsz=0x2ab7000
> [   36.821918] kexec-bzImage64: Loaded initrd at 0x23bd0b000 bufsz=0x16f40a8 memsz=0x16f40a8
> [   36.821920] kexec-bzImage64: Final command line is: root=/dev/mapper/test-root crashkernel=auto rd.lvm.lv=test/root
> [   36.821925] kexec-bzImage64: E820 memmap:
> [   36.821926] kexec-bzImage64: 0000000000000000-000000000009ffff (1)
> [   36.821928] kexec-bzImage64: 0000000000100000-0000000000811fff (1)
> [   36.821930] kexec-bzImage64: 0000000000812000-0000000000812fff (2)
> [   36.821931] kexec-bzImage64: 0000000000813000-00000000bee38fff (1)
> [   36.821933] kexec-bzImage64: 00000000bee39000-00000000beec2fff (2)
> [   36.821934] kexec-bzImage64: 00000000beec3000-00000000bf8ecfff (1)
> [   36.821935] kexec-bzImage64: 00000000bf8ed000-00000000bfb6cfff (2)
> [   36.821936] kexec-bzImage64: 00000000bfb6d000-00000000bfb7efff (3)
> [   36.821937] kexec-bzImage64: 00000000bfb7f000-00000000bfbfefff (4)
> [   36.821938] kexec-bzImage64: 00000000bfbff000-00000000bff7bfff (1)
> [   36.821939] kexec-bzImage64: 00000000bff7c000-00000000bfffffff (2)
> [   36.821940] kexec-bzImage64: 00000000feffc000-00000000feffffff (2)
> [   36.821941] kexec-bzImage64: 00000000ffc00000-00000000ffffffff (2)
> [   36.821942] kexec-bzImage64: 0000000100000000-000000023fffffff (1)
> [   36.872348] kexec_file: nr_segments = 4
> [   36.872356] kexec_file: segment[0]: buf=0x000000005314ece7 bufsz=0x4000 mem=0x23fffb000 memsz=0x5000
> [   36.872370] kexec_file: segment[1]: buf=0x000000006e59b143 bufsz=0x12d0 mem=0x23fff9000 memsz=0x2000
> [   36.872374] kexec_file: segment[2]: buf=0x00000000eb7b1fc3 bufsz=0xd73400 mem=0x23d400000 memsz=0x2ab7000
> [   36.882172] kexec_file: segment[3]: buf=0x000000006af76441 bufsz=0x16f40a8 mem=0x23bd0b000 memsz=0x16f5000
> [   36.889113] kexec_file: kexec_file_load: type:0, start:0x23fffb150 head:0x101a2e002 flags:0x8
> 
> Changes in v3:
> ==========
> - Rename kexec_core_dbg_print to kexec_dbg_print
> - Remove unnecessary segments prints
> - Remove patch "kexec_file: Fix the issue of mismatch between loop variable types"
> 
> Qiang Ma (3):
>   kexec: Fix uninitialized struct kimage *image pointer
>   kexec: add kexec flag to control debug printing
>   kexec: print out debugging message if required for kexec_load
> 
>  include/linux/kexec.h      | 9 +++++----
>  include/uapi/linux/kexec.h | 1 +
>  kernel/kexec.c             | 8 +++++++-
>  kernel/kexec_core.c        | 4 +++-
>  kernel/kexec_file.c        | 4 +---
>  5 files changed, 17 insertions(+), 9 deletions(-)
> 
> -- 
> 2.20.1
> 


