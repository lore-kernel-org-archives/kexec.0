Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF4FCD3440
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=75MuRIWX+9q3y2CqCW8GwR/Jej0xVMkwMfPONhloaB0=; b=LguAxipCbFSP4p5RyY4O59IpuE
	2PdV2zioHzaEMxScvQ7DVnhnbIy6jZ69iylvjEfpJ+ENceFkJ3QK8R6tRzBc+1S3rZvpNRZ9QAr20
	Ios6wC+hyYd065ukDqeWaIpUTH1TelhDE0RblMXRWTluukE8TQ4mzxtSOa/khUbgchCR7dKliQEf8
	O2g+SSGyZSdBBMTbY/9bCQub49l5fLahcAQmGL5ruhx+IqVvknf9CX8GugUWiN7aJSip+8vGzySiy
	CdS5u7pKPGSEK2HnB4VMcnWE64PXYmymGplQM0gN0OL5wKDomKiKWNRL0DF8SX1jAQ0/pIJa5l4f/
	Csw0Ir4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKeG5-00000001Lp1-3fJ7;
	Wed, 06 May 2026 15:33:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKeG5-00000001Lo5-0DjG
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 15:33:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5557942A16;
	Wed,  6 May 2026 15:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5B2C4AF09;
	Wed,  6 May 2026 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081636;
	bh=KAAcsVlrAQHEn5ZduHvrTDwo6rEBUA9pxPhqYP8VLFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UuvduOM4TMhGvVA0HGnkNRuQTeLyw6AuYYj2dpTXhyAqb86Tn5+FbuzmIqyVCWEKU
	 QvbI0SAOEgiH8q1h+7jsaWusaVnGAHIFy/fsFAFXbeM49p5olkEBnW51Anrmdad1M9
	 7/MbeYpwijXwy6+DFzC68IcUrdFPr98iboHAiycH6e92h9NxXskNkFJSjn1Y4NcLi2
	 qgVlUZJ46/3lu46tTxpBqh78r+yLgUk4QAiQHnhuYo3VhG/9fgaGP9+YJ0jIVfX5F2
	 im5hKkPaUHmLKNXTLBzC3sB5vKdscEyjOKgetIQxvlOl7kfFYYuUEEo+xXD3GbfNUQ
	 /PdQ+ST0beJmA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  rppt@kernel.org,
  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  liaoyuanhong@vivo.com,  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  graf@amazon.com,  mario.limonciello@amd.com
Subject: Re: [PATCH v1 1/3] liveupdate: skip serialization for
 context-preserving kexec
In-Reply-To: <aftZZ5AuQcNuqInP@google.com> (Pasha Tatashin's message of "Wed,
	6 May 2026 11:12:26 -0400")
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
	<20260506043200.2025677-6-pasha.tatashin@soleen.com>
	<2vxz34050wi7.fsf@kernel.org> <aftZZ5AuQcNuqInP@google.com>
Date: Wed, 06 May 2026 17:33:52 +0200
Message-ID: <2vxzjytgzh5r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_083357_115375_78CD007A 
X-CRM114-Status: GOOD (  14.58  )
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

On Wed, May 06 2026, Pasha Tatashin wrote:

> On 05-06 10:31, Pratyush Yadav wrote:
>> Hi Pasha,
>> 
>> On Wed, May 06 2026, Pasha Tatashin wrote:
>> 
>> > A preserve_context kexec returns to the current kernel, which
>> > is unrelated to live update where the state is passed to the next
>> > kernel. Skip liveupdate_reboot() in this case to avoid serialization
>> > and prevent sessions from being left in a frozen state upon return.
>> 
>> Should we also stop KHO? Now it is stateless and always finalized. I am
>
> No. KHO preserves kernel internal memory; for context-preserved 
> kexec, the 2nd kernel and the 1st kernel do not have overlapping 
> memory. So, whatever the 1st kernel maintains in KHO is an internal 
> detail of the 1st kernel. Once we return from the 2nd kernel to the 1st 
> kernel, all KHO memory is going to stay as-is, and the 1st kernel can 
> even perform a regular kexec or live update later.

My point is that we keep KHO data in the 1st kernel but do not pass it
to the 2nd kernel via setup_data or the devicetree because it should not
use that memory anyway. So essentially we add a check in
kho_fill_kimage() and return early if preserve_context is set.

I don't think it makes much difference in practice so no strong
opinions. Fine either way.

[...]

-- 
Regards,
Pratyush Yadav

