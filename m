Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC60C4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 17:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zpURTYnQzwiFMsyx1tSoe2TFcVZCMWI4d755k2PCqt4=; b=YtOp84GpmXV2xUrScGHVbXV4t9
	W3ttpwolhspFCSN9AR8KPqE1O3e+0vq0Fa363JoN8U4ihTGGIjnUPkQxsyf6PbS6Zvtb5Gu/LOi6e
	DC16ch20iF5pH66kvU+fIfExi7sARjh+IGoKgJdA0cKFkG9hkObZKodfKJQ40rGxU85RsTK+gP+bx
	CcmKuizl7lliGc4b91BKZrMdpN2IqIHIyeP+XxeyybhMvqI3nA4fNaw1o602k2F8RtcHP7guom1M/
	YI/ZT7ZshFCL853Ch0hrQjho25k40WgGl+yJ4XWrzWcqu0lmOy7iWKUKyBV0aLy9nJhCyqGcCGhP6
	hoo5TKXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rECH4-0048nR-2s;
	Fri, 15 Dec 2023 17:46:58 +0000
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rECH2-0048iI-02
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 17:46:57 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:41064)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rECGj-00CCA6-Dn; Fri, 15 Dec 2023 10:46:37 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:50734 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rECGi-00CJs3-Ex; Fri, 15 Dec 2023 10:46:37 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  x86@kernel.org,  Andrew Morton <akpm@linux-foundation.org>,  Thomas
 Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Borislav
 Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,  "H.
 Peter Anvin" <hpa@zytor.com>,  Jonathan Corbet <corbet@lwn.net>
References: <20231215080910.173338-1-ytcoode@gmail.com>
	<20231215080910.173338-2-ytcoode@gmail.com>
Date: Fri, 15 Dec 2023 11:46:28 -0600
In-Reply-To: <20231215080910.173338-2-ytcoode@gmail.com> (Yuntao Wang's
	message of "Fri, 15 Dec 2023 16:09:08 +0800")
Message-ID: <87a5qb4avf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1rECGi-00CJs3-Ex;;;mid=<87a5qb4avf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX189yCEqcjYR5MZGxwEuoh60iLC+05tSlWI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] kexec_file: fix incorrect end value passed to
 kimage_is_destination_range()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_094656_046407_63DA63FF 
X-CRM114-Status: GOOD (  20.09  )
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

Yuntao Wang <ytcoode@gmail.com> writes:

> The end parameter received by kimage_is_destination_range() should be the
> last valid byte address of the target memory segment plus 1. However, in
> the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
> the corresponding value passed to kimage_is_destination_range() is the last
> valid byte address of the target memory segment, which is 1 less. Fix
> it.

If that is true we I think we should rather fix
kimage_is_destination_range.

Otherwise we run the risk of having areas whose end is not
representable, epecially on 32bit.


Eric


> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  kernel/kexec_file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f9a419cd22d4..26be070d3bdd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -435,13 +435,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  		if (temp_start < start || temp_start < kbuf->buf_min)
>  			return 0;
>  
> -		temp_end = temp_start + kbuf->memsz - 1;
> -
>  		/*
>  		 * Make sure this does not conflict with any of existing
>  		 * segments
>  		 */
> -		if (kimage_is_destination_range(image, temp_start, temp_end)) {
> +		if (kimage_is_destination_range(image, temp_start,
> +						temp_start + kbuf->memsz)) {
>  			temp_start = temp_start - PAGE_SIZE;
>  			continue;
>  		}
> @@ -475,7 +474,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  		 * Make sure this does not conflict with any of existing
>  		 * segments
>  		 */
> -		if (kimage_is_destination_range(image, temp_start, temp_end)) {
> +		if (kimage_is_destination_range(image, temp_start, temp_end + 1)) {
>  			temp_start = temp_start + PAGE_SIZE;
>  			continue;
>  		}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
