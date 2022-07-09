Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083FCC433EF
	for <kexec@archiver.kernel.org>; Sat,  9 Jul 2022 00:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sCcf/0i4Tv5omR0qNt2QmWlxalUpqMOnfI1rv8ZVGWo=; b=p7o6wycSpNdNfN
	l48pu1K4SmjSP6iroZa3UjPeJn9Z9Peqg6Ve0/lJ38gszjqO67OzaNBBmL5PFpyvtLekhv2q2lBRE
	/W1ZYY6fEfwcZxGYoG6rUoO/3o8GuDgRM+A1+9xAAE8BBjPTrblE/pQ9edsLirbkD3+sq/a6ZPt7K
	h6/7RUL79YexYnbGsol+Zc18fRVQ5e7UMc4zp9Xf7XDrNNYhVXmKXgdlNV+28jn3PnilNBGIsA3yw
	EZ/ZkRVbgfqfCtOBz1WvKFIwM6rh5yf9Q2oPrAmK5r5L3JMtEHLptr8whM6nz/pizbhJC34O0jP8B
	viFmKh+0mdmajxOOnVzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9y9z-006Rp7-P4; Sat, 09 Jul 2022 00:17:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9y9w-006RoH-Ug
	for kexec@lists.infradead.org; Sat, 09 Jul 2022 00:17:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657325839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ko4GkJU0Tn8zbLKOIgGsmDKDvugLe86WnU6pUPW6HE=;
	b=VDCrOXZhK05NrchyStYlRwlYtsBUi+3Nh7oHk6UT40moN58hkw+r8D3WSrlpb38d3T3bSd
	OUi0v4MZpsxvtFT0cYcANpxCo1nb26eGa5likGRYkBXVzdkw/7kqkeib2u+G1xzJo67SDY
	WaKk7788dpM9rOo5sgs47zD1pS5jFTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-Qq9SNVonNPKWeLsxs3H5wQ-1; Fri, 08 Jul 2022 20:17:09 -0400
X-MC-Unique: Qq9SNVonNPKWeLsxs3H5wQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EB45101A54E;
	Sat,  9 Jul 2022 00:17:09 +0000 (UTC)
Received: from localhost (ovpn-12-42.pek2.redhat.com [10.72.12.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A579AC35979;
	Sat,  9 Jul 2022 00:17:08 +0000 (UTC)
Date: Sat, 9 Jul 2022 08:17:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Jianglei Nie <niejianglei2021@163.com>, akpm@linux-foundation.org
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <20220709001704.GA342876@MiWiFi-R3L-srv>
References: <20220704081839.2232996-1-niejianglei2021@163.com>
 <YsfsIzjmhR5VQU3N@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YsfsIzjmhR5VQU3N@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_171721_287183_3C17161D 
X-CRM114-Status: GOOD (  24.20  )
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

On 07/08/22 at 04:34pm, Baoquan He wrote:
> On 07/04/22 at 04:18pm, Jianglei Nie wrote:
> > elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> > kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> > predefined value. If parse_crash_elf_headers() occurs some error and
> > returns a negetive value, the elfcorehdr_addr should be released with
> > elfcorehdr_free().
> > 
> > We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> > fails.
> 
> LGTM,
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Sorry, I didn't check the code change carefully. This v2 is not right. I
thought Jianglei took my suggested code change directly. Seems he
mistakenly took part of them and caused error.

> 
> > 
> > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > ---
> >  fs/proc/vmcore.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 4eaeb645e759..86887bd90263 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
> >  	rc = parse_crash_elf_headers();
> >  	if (rc) {
> >  		pr_warn("Kdump: vmcore not initialized\n");
> > -		return rc;
> > +		goto fail;
> >  	}
> >  	elfcorehdr_free(elfcorehdr_addr);
        ~~
        this line should be removed.
> >  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> > @@ -1577,6 +1577,9 @@ static int __init vmcore_init(void)
> >  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
> >  	if (proc_vmcore)
> >  		proc_vmcore->size = vmcore_size;
> > +
> > +fail:
> > +	elfcorehdr_free(elfcorehdr_addr);
> >  	return 0;
        ^
        return rc;  the returned value is wrong with v2.

What I suggested is as below. 

Andrew, please drop the one merged into mm-unstable branch.

Hi Jianglei,

Can you post v3 with below correct change and add Andrew to CC?

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4eaeb645e759..390515c249dd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1569,15 +1569,16 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		pr_warn("Kdump: vmcore not initialized\n");
-		return rc;
+		goto fail;
 	}
-	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
 
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
-	return 0;
+fail:
+	elfcorehdr_free(elfcorehdr_addr);
+	return rc;
 }
 fs_initcall(vmcore_init);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
