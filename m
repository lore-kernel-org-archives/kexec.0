Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6242C77B7F
	for <kexec@archiver.kernel.org>; Mon,  8 May 2023 05:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y5I3w/MjmyUBJ3fx26URyszw6Al8eNq+tEDoN/6Y4Y8=; b=E0fhXvhd6G3bli
	gSA+iEV+yAc2s4nwoQJHT1+Iwe1kfpBP70RN5hQo1WO1eDZ/CN5kSdbYHTtAKUvJ85nfZIP5q7a2h
	sonARWQDb3PdHGiVbA67VImc5/A8u7AxtMfMUkAtjv+6KIBHLdj19e9bUpxo/2sr+uProDcF4JZdD
	7BB7UCJXDOXSLdYil8PaWHhE7tb16Ej1kmF6eWPQGfG+M2tf+04tMKwBPxnYoR0sH/kk5z/7jTyB2
	qhiBqWhG9NwfM+LCbxkqALj3CmiSATMgrSWBzlLY6VDBiH+VUZ1XgSeGIvKC+3vW0bLWZ1g2D21hi
	TacA/taNp1am4ck3v6Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvtC4-00HHUc-0y;
	Mon, 08 May 2023 05:13:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pvtBz-00HHTX-0m
	for kexec@lists.infradead.org;
	Mon, 08 May 2023 05:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683522824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqZQK3QfhlPN4uIEbn/A5TFDuRAUXf6WUrZ0TZoXUho=;
	b=VHYfVfrwK35uqdhMBVrh5GGMtJdJH6eYqNdJ8b746+8vfXuk4qPB/V1V4OTqaQ3PYHmOqt
	lEagZz17oXvqrgXiE2mlKGm/X+77S/A4w4RnxLkv99/xBcluFtQxB1GxICqzCAV20uO0Fu
	Ts1SoCf9g9ivOlzhb55pt9boyEOFNSc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-k-7Bb2lfNRmvx1_jf7eV9g-1; Mon, 08 May 2023 01:13:40 -0400
X-MC-Unique: k-7Bb2lfNRmvx1_jf7eV9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 908E73806627;
	Mon,  8 May 2023 05:13:39 +0000 (UTC)
Received: from localhost (ovpn-12-62.pek2.redhat.com [10.72.12.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BC3140C2063;
	Mon,  8 May 2023 05:13:38 +0000 (UTC)
Date: Mon, 8 May 2023 13:13:33 +0800
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
Subject: Re: [PATCH v22 6/8] crash: hotplug support for kexec_load()
Message-ID: <ZFiE/TXDtrt/y73w@MiWiFi-R3L-srv>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-7-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230503224145.7405-7-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230507_221347_355795_226FD166 
X-CRM114-Status: GOOD (  30.69  )
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

On 05/03/23 at 06:41pm, Eric DeVolder wrote:
> The hotplug support for kexec_load() requires coordination with
> userspace, and therefore a little extra help from the kernel to
> facilitate the coordination.
> 
> In the absence of the solution contained within this particular
> patch, if a kdump capture kernel is loaded via kexec_load() syscall,
> then the crash hotplug logic would find the segment containing the
> elfcorehdr, and upon a hotplug event, rewrite the elfcorehdr. While
> generally speaking that is the desired behavior and outcome, a
> problem arises from the fact that if the kdump image includes a
> purgatory that performs a digest checksum, then that check would
> fail (because the elfcorehdr was changed), and the capture kernel
> would fail to boot and no kdump occur.
> 
> Therefore, what is needed is for the userspace kexec-tools to
> indicate to the kernel whether or not the supplied kdump image/
> elfcorehdr can be modified (because the kexec-tools excludes the
> elfcorehdr from the digest, and sizes the elfcorehdr memory buffer
> appropriately).
> 
> To solve these problems, this patch introduces:
>  - a new kexec flag KEXEC_UPATE_ELFCOREHDR to indicate that it is
>    safe for the kernel to modify the elfcorehdr (because kexec-tools
>    has excluded the elfcorehdr from the digest).
>  - the /sys/kernel/crash_elfcorehdr_size node to communicate to
>    kexec-tools what the preferred size of the elfcorehdr memory buffer
>    should be in order to accommodate hotplug changes.
>  - The sysfs crash_hotplug nodes (ie.
>    /sys/devices/system/[cpu|memory]/crash_hotplug) are now dynamic in
>    that they examine kexec_file_load() vs kexec_load(), and when
>    kexec_load(), whether or not KEXEC_UPDATE_ELFCOREHDR is in effect.
>    This is critical so that the udev rule processing of crash_hotplug
>    indicates correctly (ie. the userspace unload-then-load of the
>    kdump of the kdump image can be skipped, or not).
> 
> With this patch in place, I believe the following statements to be true
> (with local testing to verify):
> 
>  - For systems which have these kernel changes in place, but not the
>    corresponding changes to the crash hot plug udev rules and
>    kexec-tools, (ie "older" systems) those systems will continue to
>    unload-then-load the kdump image, as has always been done. The
>    kexec-tools will not set KEXEC_UPDATE_ELFCOREHDR.
>  - For systems which have these kernel changes in place and the proposed
>    udev rule changes in place, but not the kexec-tools changes in place:
>     - the use of kexec_load() will not set KEXEC_UPDATE_ELFCOREHDR and
>       so the unload-then-reload of kdump image will occur (the sysfs
>       crash_hotplug nodes will show 0).
>     - the use of kexec_file_load() will permit sysfs crash_hotplug nodes
>       to show 1, and the kernel will modify the elfcorehdr directly. And
>       with the udev changes in place, the unload-then-load will not occur!
>  - For systems which have these kernel changes as well as the udev and
>    kexec-tools changes in place, then the user/admin has full authority
>    over the enablement and support of crash hotplug support, whether via
>    kexec_file_load() or kexec_load().
> 
> Said differently, as kexec_load() was/is widely in use, these changes
> permit it to continue to be used as-is (retaining the current unload-then-
> reload behavior) until such time as the udev and kexec-tools changes can
> be rolled out as well.
> 
> I've intentionally kept the changes related to userspace coordination
> for kexec_load() separate as this need was identified late; the
> rest of this series has been generally reviewed and accepted. Once
> this support has been vetted, I can refactor if needed.
> 
> Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
