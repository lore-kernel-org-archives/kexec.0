Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A96C44512
	for <kexec@archiver.kernel.org>; Sun, 19 Jul 2026 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hi0SGV5F/5QPo8XX0tA2GM/CvWtlCpdy3l4mMqNXe0k=; b=T2jaKp1Z79O12FV3QjxItPzAJR
	+cFTN19yt5xosA8WAXpeAX/9EjLuZ4j/HpfltLtB0LAZwAygDxWBGfkZxYv/aK5vhgjlFIEjFgnXb
	YbALijZPeI3RqKJZviEmB584pcUJPEnJOpY6Y8/tZNctgUEf6bVQ8ETZOYI8XhcSDDFFKIz5f9qn8
	5yW2Wip0WXzDfDoOuWmKbXoeXnPMPNHyD7murne+JIsbyxjA3/fQ1/xw7+l6ulzebmEcGZNg/b7pN
	oTGmdHD/rR/jVVGneBV6AGz9K6QRCQ2Ex/st2LQXV9nXk8MXjxkSCJHBIDtHev4HoI/oJ+YgCvDt9
	OVEEKCDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlV19-00000005CDE-1iUF;
	Sun, 19 Jul 2026 17:09:31 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlV16-00000005CCq-0c9X
	for kexec@lists.infradead.org;
	Sun, 19 Jul 2026 17:09:29 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-92e57a753f9so837353685a.2
        for <kexec@lists.infradead.org>; Sun, 19 Jul 2026 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784480966; x=1785085766; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hi0SGV5F/5QPo8XX0tA2GM/CvWtlCpdy3l4mMqNXe0k=;
        b=NgfMXCzkjxyO3EYmZaXT8HNG9q8oaWOKbG47iz/0VAApteqTvKchLO6015YEhR6A/P
         mWtW0JuCFOkf/+g1lBFw4z2JnnMPv2k/sojV9cKK18weRaJ2V5SVq+C5HxpRMPXRqSS/
         UkqkEF1jKLz2UCFbjukI5hAZPYyu1LPlWWuTLqXX4E+2swSjMs/QrYIz9U5K4FGXs6QT
         QNaiVonocZ8xtXcwch3hgXmPVosJJn5RWqmsStnsRzjQy7hWIbntahAapN/2olkER7Im
         Tv0LEVCBsexZBbHM5kRxDzc18wy6rMorECPcYvzsIQxb36ynyuDhxXRxbS+biLHKB2XG
         nptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784480966; x=1785085766;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hi0SGV5F/5QPo8XX0tA2GM/CvWtlCpdy3l4mMqNXe0k=;
        b=smc+fXndZ0FUITiDl2lUt4yajUIJjfOAMHVbkswBlj9NqG9UklT7ilXk1ESfvJUqKd
         adUZrV03eqzN+zRUKiQZRWCEqVUAYD/hZfXDogcYWhx/cnEwzjeWM5O32xnxI5mUPIxu
         PQXXuj9oBao48H9rAImI1ZU6MKjrmCtrvI8klLlNsEaihuCvgJzqL8HjdulCghA38Z7c
         gAIpCD5SyBqsOEO81mXTlcTp0revL9yiVxXFWN/L5nXeEYE0cLSUnmWQMOtSZjLAt2VF
         jjXUAv5uVSnd1hoQ6wtR1CSAopKzvIYuex1CEyLtTNh/Kjj6eDPMSO/OLqKnDniY/KnI
         MpkA==
X-Gm-Message-State: AOJu0YysECQK8oEX5qBboKBRj4sUdmr1znXo7V8dtfuVqLChUnm7X7YK
	m6tPLI/4jZLI0pn6coYvEfaK8FDYQ4K2twtbnWztPGMjVvzonc7q5spjee0yoRdqDxE=
X-Gm-Gg: AfdE7cnsWkJcFDTz+q5NmX7FhTgLyLcHg2yCNQDbRsks3FAuXKVVn2l0/tFQucp3U8s
	+uTiws7h76GCHatuYkVbHuJhIkjOyCrz4G9m/vXtUhbhWhMWAyyGT5SzgOr94JqVtVvQVg67bNb
	fhPVT8YjPaQB/DeInCa+HjjVQp8T4BXxvILGWKJv1wsaTU5eQMMrE2d27NRsBV8YiBcRxopT0NX
	l+Wi6hBAlvLNfTRorwU+V3TrT64MXr8v6rDJ2DVcvaLRK/T7KHnFpfdl1DWqoS2ASUfGoi0y520
	kcAeLjYLhVqGocLuIgEOWs20sPDoLbIkMXocRPZ65u2j11bCJCcJFXaxigwGNp6MoydWTMuvOfU
	C9zSLqpw3LZc/NS3wlchEQ6GKHOFaWzbAh41bx7p18idJ2aPYaSIC8VKtf/tyWyCRy60rW/L3OY
	32JbYFV0buKpvCmpbTsaGPlRmZggX3DkNCDCT13ZY=
X-Received: by 2002:a05:620a:468e:b0:92e:9d63:a6f6 with SMTP id af79cd13be357-930b3eaa9fbmr1122131885a.17.1784480966677;
        Sun, 19 Jul 2026 10:09:26 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5494153sm686226385a.43.2026.07.19.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 10:09:26 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Matlack <dmatlack@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>
In-Reply-To: <20260528174140.1921129-1-dmatlack@google.com>
References: <20260528174140.1921129-1-dmatlack@google.com>
Subject: Re: [PATCH 0/2] liveupdate: Small FLB fixes
Message-Id: <178448096578.306041.16503153363800577876.b4-ty@b4>
Date: Sun, 19 Jul 2026 17:09:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_100928_212745_C18C9702 
X-CRM114-Status: GOOD (  10.17  )
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


On Thu, 28 May 2026 17:41:38 +0000, David Matlack wrote:
> This series has 2 small fixes to how FLBs are managed. First is to
> increase the outgoing FLB refcount during liveupdate_flb_get_outgoing()
> so it cannot be freed while the caller is using it, and to align with
> the semantics of liveupdate_flb_get_incoming(). The second is to prevent
> FLB retrieve() from being called multiple times if the first attempt
> fails.
> 
> [...]

Applied, thanks!

[1/2] liveupdate: Reference count outgoing FLB data
      commit: 820d139e43c045c3df7d03d35c78ef766a64f1ee
[2/2] liveupdate: Remember FLB retrieve() status
      commit: f03f4d61010786cf38fa8cdae640e8f965002d45

Best regards,
-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


