Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD57C48BEB
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 11:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k2BtSDMYwVO3G4zzyrMhhBV/fp6BIjoqRUNF0derj4E=; b=arcW78RwaijApR
	yeYaUwWhhTQzEZbUtJ3Xv9xpxyE6zeUHNLk5zuYm9Dtl5Fq4UnAjse4tMwGUfSBy4vA3pN43nkMNG
	r2Dr5jIJS4yQTaQ+050cj7dnKXoWu+83SodlEfjaS1T7aIxXLnv6V2qujVGWygqOXKwTpycdrk6Ri
	eElze9wXbU8/5AncbholCjPeeUSv2AgWypWHbm5lIfmlCjjhl/K0WAOu+PVKYmI6hKhBXscEpIxjQ
	+LgCP29VPBzCQo6WLodl3RrSGR35baThMDoW/+wstqDLhsMtxD1uUqJeOpuxVJ5M8eQeXCjNWDJMx
	gV/7sOQvABpDE4xF+93A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd6pu-00000004Zzu-2SZJ;
	Thu, 22 Feb 2024 11:01:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd6ps-00000004Zyv-0orf
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 11:01:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708599711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFwcHVEtiDhTvRigoTq212XHeG8ky/6AjwT+KI1KNaQ=;
	b=FB0ulYTQNFlguGoSzBBdHDHlMbDZ/fWOMfUHgo5BrDz8oAwtUXjrAdaEEcLTsN9XvJvRMt
	RkyKYbckri1SIkY1nfA3hcNzU3VO6RSZr6UuE0BiB7YkJfK/IE4cXIOsj+7eibAklfBmuU
	4XPJ4ab83ufeeoBF8LS+4i0SmjEKnK8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-OcOjjzq9PGa9bb85kAn-jA-1; Thu,
 22 Feb 2024 06:01:46 -0500
X-MC-Unique: OcOjjzq9PGa9bb85kAn-jA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26A20386A0A0;
	Thu, 22 Feb 2024 11:01:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 73904492BD7;
	Thu, 22 Feb 2024 11:01:44 +0000 (UTC)
Date: Thu, 22 Feb 2024 19:01:41 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 07/16] x86/mm: Return correct level from
 lookup_address() if pte is none
Message-ID: <ZdcplT8Xb5eevu/9@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
 <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
 <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
 <p34d7e5r3gkcj2xl5jycyldvpkmcllmhzioaqcmseeugl3eq73@plk43dd4luzu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <p34d7e5r3gkcj2xl5jycyldvpkmcllmhzioaqcmseeugl3eq73@plk43dd4luzu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_030152_348569_F5846BF7 
X-CRM114-Status: GOOD (  16.74  )
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

On 02/21/24 at 04:15pm, Kirill A. Shutemov wrote:
> On Wed, Feb 21, 2024 at 10:37:29AM +0800, Baoquan He wrote:
> > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > index 3612e3167147..425ff6e192e6 100644
> > > --- a/arch/x86/mm/pat/set_memory.c
> > > +++ b/arch/x86/mm/pat/set_memory.c
> > > @@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
> > >  
> > >  /*
> > >   * Lookup the page table entry for a virtual address in a specific pgd.
> > > - * Return a pointer to the entry and the level of the mapping.
> > > + * Return a pointer to the entry and the level of the mapping (or NULL if
> > > + * the entry is none) and level of the entry.
> >                        ^ this right parenthesis may need be moved to the end.
> > 
> > 
> > =======
> >  * Return a pointer to the entry and the level of the mapping (or NULL if
> >  * the entry is none and level of the entry).
> > =======
> 
> Emm.. I like my variant more. We return level regardless if the entry none
> or not. I don't see a reason to repeat it twice.


 * Lookup the page table entry for a virtual address in a specific pgd.
 * Return a pointer to the entry and the level of the mapping (or NULL if
 * the entry is none) and level of the entry.

Hmm, I am confused. Why do we need to stress the level of the mapping
and level of the entry? Wondering what is the difference. I must miss
something.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
