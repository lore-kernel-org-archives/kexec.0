Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF238C76196
	for <kexec@archiver.kernel.org>; Thu,  6 Apr 2023 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YRxkmUap4nYl2byta7y9I8el93XlQW8hXuzTotvDiC8=; b=UxyMEd29q/6lgw
	ZODQjP1dPXApf2ETQew9FYrr/kKQH/iGJE1IuttP2AjGa89m8BpD3fl2LJRP4ZS5S/21O6vxxU7SO
	R1cqlDIYP3iQD/MLJQ+9JuQEXUeCP8C1LJ57PZYcV6kdHyRDJJkul5V5Qi/1pOLWbMmsm1Oc8hd/U
	Z7dp8hHF8ENC9d1OONtSSlUDQbDgFk++ne4DAJAIlqk6SOZzDA4V7t6raHBg1HKh2ANqsoF9zqBHK
	/0ZMjDr+pLgpZ0qoN5qjpQU4bv1YHqx7wMiaSaftx6KmSWcaFwjoKgrSIjMHovdZgFnKrtSqMe72c
	r1jsVqvA84lfNvBYYrXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkNRs-0077Cy-2v;
	Thu, 06 Apr 2023 11:06:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkNRq-0077C0-0Q
	for kexec@lists.infradead.org;
	Thu, 06 Apr 2023 11:06:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680779193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LSpYEks1T5f1HgeKXvgnDWGtTBs8ltEecfJ6Ag+UgLU=;
	b=WuYmFnb4aaDlLnQAwIrUUhLTR6eEwE4vokKPWLColy+//AUamCCUyxIH4oNx/Uci+7rE3q
	RFuHUBvBYF6SOAXDphESKnKq+tqq7Sg3GBbYbF8T5WJmdP8mqARIVtnbvXONTnePJBCnjr
	ttdxdw44GCTm61OIUGbsKCzfUKuZARM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-jJolPkiZMh25d-WtlECE3g-1; Thu, 06 Apr 2023 07:06:27 -0400
X-MC-Unique: jJolPkiZMh25d-WtlECE3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12FAF3C0ED6C;
	Thu,  6 Apr 2023 11:06:26 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D3171121314;
	Thu,  6 Apr 2023 11:06:23 +0000 (UTC)
Date: Thu, 6 Apr 2023 19:06:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v21 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Message-ID: <ZC6nq13EDIrK1XFe@MiWiFi-R3L-srv>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_040634_238904_407D088B 
X-CRM114-Status: GOOD (  26.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 04/04/23 at 02:03pm, Eric DeVolder wrote:
> Once the kdump service is loaded, if changes to CPUs or memory occur,
> either by hot un/plug or off/onlining, the crash elfcorehdr must also
> be updated.
> 
> The elfcorehdr describes to kdump the CPUs and memory in the system,
> and any inaccuracies can result in a vmcore with missing CPU context
> or memory regions.
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (eg. kernel, initrd, boot_params, purgatory and
> elfcorehdr) by the userspace kexec utility. In the original post I
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> This patchset introduces a generic crash handler that registers with
> the CPU and memory notifiers. Upon CPU or memory changes, from either
> hot un/plug or off/onlining, this generic handler is invoked and
> performs important housekeeping, for example obtaining the appropriate
> lock, and then invokes an architecture specific handler to do the
> appropriate elfcorehdr update.
> 
> Note the description in patch 'crash: change crash_prepare_elf64_headers()
> to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
> enables further optimizations related to CPU plug/unplug/online/offline
> performance of elfcorehdr updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory; thus no involvement
> with userspace needed.
> 
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
> 
>  - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>    Add the following as the first lines to the RHEL udev rule file
>    /usr/lib/udev/rules.d/98-kexec.rules:
> 
>    # The kernel updates the crash elfcorehdr for CPU and memory changes
>    SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>    SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
>    With this changeset applied, the two rules evaluate to false for
>    CPU and memory change events and thus skip the userspace
>    unload-then-reload of kdump.
> 
>  - Change to the kexec_file_load for loading the kdump kernel:
>    Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>     standard_kexec_args="-p -d -s"
>    which adds the -s to select kexec_file_load() syscall.
> 
> This kernel patchset also supports kexec_load() with a modified kexec
> userspace utility. A working changeset to the kexec userspace utility
> is posted to the kexec-tools mailing list here:
> 
>  http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
> 
> To use the kexec-tools patch, apply, build and install kexec-tools,
> then change the kdumpctl's standard_kexec_args to replace the -s with
> --hotplug. The removal of -s reverts to the kexec_load syscall and
> the addition of --hotplug invokes the changes put forth in the
> kexec-tools patch.

Other than the nitpick in patch 2, this series looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
