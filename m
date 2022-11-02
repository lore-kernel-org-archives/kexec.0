Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B20C4332F
	for <kexec@archiver.kernel.org>; Wed,  2 Nov 2022 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GeB8fEq1eUQlhw+6umqvhdboOI34R97ABNyQthCWrBM=; b=DkyRJAqeVUqMlZ
	UjRg1haW1E6E6CsXYJvlrWX5R1WHOtbHNn5OGW39nBzkCvJ+bY3WqMXRYHgph/IXEZi/I9FE+D8D8
	SPS4/TV+CNCoPP3b5dKZxFiHvfzJq+d8lM6R7llrobABhDQES2xqnWSPTlg3dFRPiPDEgqJLWx0LM
	WNeOxmv9YBvkwihidiSAILWWa/jQHJitVS8wGkEcAHue5h2qg7vFEUkz9k9DqD1wtiTPGqEsmaFQc
	srV5FAQjX6GIajZUKbhCwUocTnxiB7FE+jVVMT9Qvk2Hg4DWXJwvNvxHNj2wolNcmgpqamUYPbvxU
	71S67OlkYuLAm/n5QnEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqJJY-00Dhh4-7o; Wed, 02 Nov 2022 19:22:16 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqJJU-00DhZ8-Mq
	for kexec@lists.infradead.org; Wed, 02 Nov 2022 19:22:14 +0000
Received: from zn.tnic (p200300ea9733e741329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e741:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 803771EC0426;
	Wed,  2 Nov 2022 20:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1667416926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=eHtgilT1Vj1C54MIidRzINaPpHXLEGjQYY8J2FhB4ZY=;
	b=HbX/HdSvS2QS8mDI/ubh3Gfb+11BgfzOATu5ygS6bVxIJDvkvRdUFBSk0GZ7yb75vN8GUw
	LF1i/u31JcNDHcSvXlCZ9f4YP8Ywnagelxn4W5AiYXs/KD2kj/FdN9WphF7eS79+aDUqFH
	7h78gghb7uWjKPTgq841cBQBlDbZclM=
Date: Wed, 2 Nov 2022 20:22:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y2LDWp3RMCAI6Egc@zn.tnic>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com>
 <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com>
 <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
 <06ef6e4b-1f42-d50f-1328-4f82fb34dd4d@oracle.com>
 <Y2KYls/Ji5E+4kPP@zn.tnic>
 <c08bb557-846c-0f82-391a-3eeda7e6ea67@oracle.com>
 <Y2K7u+KfkdBxJ01h@zn.tnic>
 <a01a43bf-0d2c-cb7c-bbe1-352b77c07fce@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a01a43bf-0d2c-cb7c-bbe1-352b77c07fce@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_122212_935777_6BC46A1B 
X-CRM114-Status: UNSURE (   8.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Nov 02, 2022 at 01:57:14PM -0500, Eric DeVolder wrote:
> But I sense I missing your point?

No no, you're spot on. So moving that into the kernel and making it more
robust is always a good thing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
