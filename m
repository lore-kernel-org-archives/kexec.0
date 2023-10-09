Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B02FE95A91
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=56lQ0YhekhoHz930MMVb61vijsO2WwgoS/EE+/crRkY=; b=wV+rfq3R/J2WD8
	dWWbLlbxXwyG5DstGyrlu0V0Fh7ORB3i+jW9z5sBZZb3AGLkv0bB85EOMeuMVrwLoLUlvJyydUaY+
	z+Uoeazcu269UVxM16dyq+z+0slRzvUadm93qAMkY/3qVYeldcdWW+Wdh7/LiLZmwU0p/2X5j05sC
	jY2TSizFYJy+jfRQgmyjugf/Qae2//tF9ICEX+TczsdOBcFIduAqT0iFkn301wPj20Zq90DWz3UoI
	HDPE3gB3QD9o6erM7KL2CfGR4YWc+Vbl8S/SJz+eqKIHhKNlC1IM5KwAXLwSyKXmK9UfSXoZWjQXx
	NcX0aWzKNAPi0LPNllAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpr10-00Atfn-2A;
	Mon, 09 Oct 2023 14:13:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpr0x-00Atf3-0z
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 14:13:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696860821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtAr6vMHSkU1o8N9xFJERXPEAH/eUDbPVOnY1/d3q0M=;
	b=P8SApZZoYp54YDOzd+JAAWM2Bz3zLiOOFoNHX9YzxemBO1ShWPTqcjKuzqq8+iVVlvJ30o
	63aVbml9IFJSPUDPo25aRhpSNoCrA979bodYhdTB9/c0TzsV8jf9h3Hb4r5JV2ZI0hjTaR
	1NM996PdLCZcMgL6rFW9200TL2+pOF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-1ORgyTEpN9-o7KLkB5trKw-1; Mon, 09 Oct 2023 10:13:15 -0400
X-MC-Unique: 1ORgyTEpN9-o7KLkB5trKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDD5881D787;
	Mon,  9 Oct 2023 14:13:14 +0000 (UTC)
Received: from localhost (unknown [10.72.112.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1498240C6EBF;
	Mon,  9 Oct 2023 14:13:13 +0000 (UTC)
Date: Mon, 9 Oct 2023 22:13:10 +0800
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
	Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] x86/tdx: Add kexec support
Message-ID: <ZSQKdrP9VE96eDxg@MiWiFi-R3L-srv>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <ZSNADxBZEDyxEnZ4@MiWiFi-R3L-srv>
 <20231009133655.3aqi4kwx7wtqgqtm@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231009133655.3aqi4kwx7wtqgqtm@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_071343_431127_CD08C8D7 
X-CRM114-Status: GOOD (  22.33  )
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

On 10/09/23 at 04:36pm, Kirill A. Shutemov wrote:
> On Mon, Oct 09, 2023 at 07:49:35AM +0800, Baoquan He wrote:
> > On 10/05/23 at 04:13pm, Kirill A. Shutemov wrote:
> > > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > > TDX guest.
> > > 
> > > They bring kexec support to the point when we can start the new kernel,
> > > but it will only be able to use single CPU. It should be enough to cover
> > > the most common case: crashkernel.
> > 
> > Not sure if this question has been raised and answered in the past. Please
> > forgive my bad memory if it has. The one cpu is fine to kdump kernel most
> > of time, while we enable all CPUs by default when kexec rebooting. And kdump
> > kernel with multiple cpu is allowed too. Wondering if there's plan to
> > support the multiple cpu on TDX in the future.
> 
> Sorry, I didn't update this part of cover letter properly, but the last
> patch of the patchset makes possible to kexec with multiple CPUs and the
> 2nd kernel will see them all. It requires support on BIOS side, otherwise
> we fallback to single CPU kexec.

Oops, I didn't read them carefully. You have mentioned that in the last
paragraph of cover letter. That's a great news, thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
