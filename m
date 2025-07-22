Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71AAC83F25
	for <kexec@archiver.kernel.org>; Tue, 22 Jul 2025 01:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEihGpmbMTbO264BqTaIMA9Tw7BYchJMrWISdonOVAc=; b=MoMIqPLB4AeIa580Q/U7KrrS9L
	qqqBOTEcvRCScdQExecZac7DJ7/6tmTlCklc2VLj36IbcsmcYTa6wD4mYlXTZWi+AxSOeO/X3rRqr
	ydmoy6H9v8bGh/V0GRebn0tdagO/0F0zM9rhMvHSEznj87cjlBSFCptXewUqlwJCGGeG7dZyIEjgx
	v/fgpZUCwCWNtInNOXIWIH/NbYlypm0vIdr9N6qwIwCrOCEW/oyh2plnJN2tLwuegdvlmyA2WR4ZM
	qpowgMA98ZL+cvgOlkWxQi1lQJ+3d9jRVhx0sa9gQ0IwalvEbbM4Dhyk3yTVcS0zI03xeyh1Ja4JZ
	1GpbPlPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue1o8-000000010r1-10f5;
	Tue, 22 Jul 2025 01:28:40 +0000
Received: from sender4-pp-o95.zoho.com ([136.143.188.95])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue1o5-000000010qK-2JbQ
	for kexec@lists.infradead.org;
	Tue, 22 Jul 2025 01:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1753147706; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UqiusmN05OylajW9v34OICXTkYdfJZFJlM02Tn1mS1THNRoOKz3a2iNXThUua0xeq/DqqGjuumZMTF2z/2FKYgHHc6Qmo/IgokwvvNTuRGs+ynPsA24NXxoauhFLaHhDI3a1pvNL4E1wj8u48+7LHOz0H8Kub5VfZwj6P7P5tLw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753147706; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UEihGpmbMTbO264BqTaIMA9Tw7BYchJMrWISdonOVAc=; 
	b=VqGlNsvXpF10PP/a3Tj4f50m1X0AYOH+3PMHZcHfQfFqWsWiVgvfZ38+WUQEsr2OjvUGxReut3S2b88BOz0E7MqTdp8XUsUIZXK1uyLmaOVH746WeK4k5rms7XMH0X3odC+TXbcLk+GryurK5yJng0sKV5/nLbnkaNsxhnQlHoc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753147706;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=UEihGpmbMTbO264BqTaIMA9Tw7BYchJMrWISdonOVAc=;
	b=ZBwRzRy72qFQxoo1J5/u6XGFBfyxHEYNJjbvPN/oZ/nNY3DreUygR8rCn4ZPMXs5
	+AY3qzEvtAppuVPpEZXWzo6ZYBBbM+U7u0+yq0M+br53pAFrbSPB2kYrEjiD94XNrFf
	fp04VsQochfIlGFhUAwMQ2n6e3kVJPZGIw7htGQI=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1753147705708573.5043315837693; Mon, 21 Jul 2025 18:28:25 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 21 Jul 2025 18:28:25 -0700 (PDT)
Date: Tue, 22 Jul 2025 05:28:25 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Pingfan Liu" <piliu@redhat.com>
Cc: "Jani Nikula" <jani.nikula@linux.intel.com>,
	"regressions" <regressions@lists.linux.dev>,
	"intel-gfx" <intel-gfx@lists.freedesktop.org>,
	"kexec" <kexec@lists.infradead.org>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"iommu" <iommu@lists.linux.dev>, "Ben Hutchings" <benh@debian.org>,
	"joonaslahtinen" <joonas.lahtinen@linux.intel.com>,
	"josesouza" <jose.souza@intel.com>,
	"davehansen" <dave.hansen@linux.intel.com>
Message-ID: <1982fbf095a.e7a2ac3764675.6794980000287835465@zohomail.com>
In-Reply-To: <CAF+s44SvWGxwty3FA6ZpR3GoXEbqXRDoT9H6KBj_jy0yM1jjLw@mail.gmail.com>
References: <197d1dc3bff.c01ddb9024897.1898328361232711826@zohomail.com>
 <cd3ca680ac5751368941713c1071e04d69544d47@intel.com> <197d710ac39.10e2c241536088.2706332519040181850@zohomail.com> <CAF+s44SvWGxwty3FA6ZpR3GoXEbqXRDoT9H6KBj_jy0yM1jjLw@mail.gmail.com>
Subject: Re: Second kexec_file_load (but not kexec_load) fails on i915 if
 CONFIG_INTEL_IOMMU_DEFAULT_ON=n
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227801649ef5f7e57bec5ce126800006a01dd62cd85321444656299f5da466f329abc9f5972571b84:zu0801122719892fc87ce9db57523071ef0000470c690de5ebc037555142d8991ec6bf643b61c310ec60ec14:rf0801122b59948fed72cf8f9346a62cd9000007820cd32a1934dea80873c00512de54f12b5e287a5a5befc3b8ef91e4:ZohoMail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_182837_669079_CA64848D 
X-CRM114-Status: UNSURE (   7.55  )
X-CRM114-Notice: Please train this message.
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

 ---- On Mon, 21 Jul 2025 18:18:48 +0400  Pingfan Liu <piliu@redhat.com> wrote --- 
 > IMHO, you could try blacklisting the i915 module to see if
I did this. Problem is in i915.
Here you can see our discussion with i915 devs: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14598
--
Askar Safin
https://types.pl/@safinaskar


