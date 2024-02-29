Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC40BC54798
	for <kexec@archiver.kernel.org>; Thu, 29 Feb 2024 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sWsn1M18DZl4PVKy5PUs2MuW/c/6imvWPCqgzV6caa0=; b=BRTmWky/QI4AWR
	0w73oF3qchPWTFyGqaXz3HJTz4ipy8qysRds7zblFt/WtXpDl7YE56MOnXRlAoogUp/m+YVW1iBqC
	WTU3OlHEe5Jrkki0tkPlqD59VcbJWthdMqdxbGDeCQKXRrGaLY5pIEAYgXJK4bpZljfy7pSrLezTq
	5lS1Nemu+wq9fESripvjCp1k2IbA7WtjLEvojUtRRUd0eooD9o+L3bTme6F9I6s/Gqy0hjskGHiP+
	f5e3uWnIfvGAfpLcroFnXJRkyKDpSokmzlxiDSWrBfacv2AXaqvA5VXo71yXapuNeA8rD9vvF5Xfq
	+8Q+YozhOQU+IH6CGBXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfbVc-0000000CbBJ-1Efd;
	Thu, 29 Feb 2024 08:11:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfbVZ-0000000Cb9D-3QUX
	for kexec@lists.infradead.org;
	Thu, 29 Feb 2024 08:11:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709194273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKgPV4KlmoWInRghtoexaD0eJgXp81WWMaJOZh2q7qI=;
	b=KN7hlPR29M7tJxZUjVgkzDZIHF8ouwEm8hsJaHmhIMBxW3+eH5FrNYtSnO4u4nqX7A7pN7
	jtIjAdcMg95FMug4G5VXC/O2h1nkD35pyzl1/N+MI46IW/iEXBup1PLgWIiU9rNrmX0kmS
	lGOIsRFJ9qbG82ycyGTvJJbLNFS2HH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-RSprWW3hOl-Jg7EwQH2YYw-1; Thu, 29 Feb 2024 03:11:09 -0500
X-MC-Unique: RSprWW3hOl-Jg7EwQH2YYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A411C106D102;
	Thu, 29 Feb 2024 08:11:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 93616112C5;
	Thu, 29 Feb 2024 08:11:06 +0000 (UTC)
Date: Thu, 29 Feb 2024 16:11:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Young <dyoung@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v17 3/6] powerpc/kexec: move *_memory_ranges functions to
 ranges.c
Message-ID: <ZeA8Fl7xVHly4Ma+@MiWiFi-R3L-srv>
References: <20240226084118.16310-1-sourabhjain@linux.ibm.com>
 <20240226084118.16310-4-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20240226084118.16310-4-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_001113_950157_7D1E388A 
X-CRM114-Status: GOOD (  13.26  )
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

On 02/26/24 at 02:11pm, Sourabh Jain wrote:
> Move the following functions form kexec/{file_load_64.c => ranges.c} and
> make them public so that components other KEXEC_FILE can also use these
                                           ^
                                          'than' missed?
> functions.
> 1. get_exclude_memory_ranges
> 2. get_reserved_memory_ranges
> 3. get_crash_memory_ranges
> 4. get_usable_memory_ranges
> 
> Later in the series get_crash_memory_ranges function is utilized for
> in-kernel updates to kdump image during CPU/Memory hotplug or
> online/offline events for both kexec_load and kexec_file_load syscalls.
> 
> Since the above functions are moved to ranges.c, some of the helper
> functions in ranges.c are no longer required to be public. Mark them as
> static and removed them from kexec_ranges.h header file.
> 
> Finally, remove the CONFIG_KEXEC_FILE build dependency for range.c
> because it is required for other config, such as CONFIG_CRASH_DUMP.
> 
> No functional changes are intended.
......snip


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
