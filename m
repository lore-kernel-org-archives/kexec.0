Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACAAC64EC7
	for <kexec@archiver.kernel.org>; Wed,  1 Mar 2023 09:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xsgorHrlIDblhV27SCeG1HsszmazWpbz+NTzWwicqKI=; b=YrxlYzgNuJkZNV
	7xCNQ5PvLvjuodI+4a8NkZmbuODvbI7d7cYPua5DPqXklgzVEWycQO+8KtHm+78knB4qzLQHm5LwJ
	2B3d5ZHL6WTUVIggAHI/qlYvgtsc642OSEfqUOhSYcFkGyHSy0F+UC6OZrliGkQOQXNv0Ku2v4zXX
	rRFCHwGHTgLaiFTSijXVB2mlfG22wY8OD6vMSvD0BK5KF/xBe41JaSIdugUI2lxiHwzQduEL763tJ
	5JJYLsmm6fAEnfS3jVQQ0ACgQ4ysbZQD87aQhVT+a/yC+3w4lUhsno0jNKa97fasQTPObqJVhWsaM
	+16qVRhRaunWHdlDR4nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXILB-00FV15-9u; Wed, 01 Mar 2023 09:01:37 +0000
Received: from mail.cannich.pl ([94.177.238.223])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXIL8-00FV0h-CL
	for kexec@lists.infradead.org; Wed, 01 Mar 2023 09:01:35 +0000
Received: by mail.cannich.pl (Postfix, from userid 1001)
	id 5DBE98414D; Wed,  1 Mar 2023 09:01:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cannich.pl; s=mail;
	t=1677661287; bh=cNbZL9WXZbgcQtzgDCharPn7EQBjUHnC1FAZ/+OQVjk=;
	h=Date:From:To:Subject:From;
	b=BSaHhhH9IhO6U+PreS1sjS4r7v1iWR8z2J97fCJ93kOVVtu3DHcp8DMVcaYx/ntlF
	 6+3JwOomNsdAvitfREcNnp9QBeUYwRv53Cs8Jde4qeWsQH9sViW5rsJCbhWwJ7Gav5
	 1luXQBm7iZuABwH7JoPjZCBq4JlyeCr6tyroSJVKOFHl0KTT+5uK3Gu3+q/b+7HJWx
	 Q/q2Ie75KhIVXL37EB6jhSJ4p5BGOVuAY2MX+JqUeKA0pUlfed84XrElWHlxJGNGe+
	 +WsBI1gdHJruAkEEPEMRjw/ONOXPMOdB1GgRO/XTZOyqiWEIa7HXd1G0Il+gHQ9Swn
	 ET+gbe7RshS8Q==
Received: by mail.cannich.pl for <kexec@lists.infradead.org>; Wed,  1 Mar 2023 09:00:23 GMT
Message-ID: <20230301074502-0.1.25.28wm.0.s65lmmoqui@cannich.pl>
Date: Wed,  1 Mar 2023 09:00:23 GMT
From: =?UTF-8?Q?"Pawe=C5=82_Kamieniecki"?= <pawel.kamieniecki@cannich.pl>
To: <kexec@lists.infradead.org>
Subject: Prezentacja
X-Mailer: mail.cannich.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_010134_637694_5FA9EE13 
X-CRM114-Status: UNSURE (   3.05  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

RHppZcWEIGRvYnJ5IQoKQ3p5IG3Ds2fFgmJ5bSBwcnplZHN0YXdpxIcgcm96d2nEhXphbmllLCBr
dMOzcmUgdW1vxbxsaXdpYSBtb25pdG9yaW5nIGthxbxkZWdvIGF1dGEgdyBjemFzaWUgcnplY3p5
d2lzdHltIHcgdHltIGplZ28gcG96eWNqxJksIHp1xbx5Y2llIHBhbGl3YSBpIHByemViaWVnPwoK
RG9kYXRrb3dvIG5hc3plIG5hcnrEmWR6aWUgbWluaW1hbGl6dWplIGtvc3p0eSB1dHJ6eW1hbmlh
IHNhbW9jaG9kw7N3LCBza3JhY2EgY3phcyBwcnplamF6ZMOzdywgYSB0YWvFvGUgdHdvcnplbmll
IHBsYW51IHRyYXMgY3p5IGRvc3Rhdy4KClogbmFzemVqIHdpZWR6eSBpIGRvxZt3aWFkY3plbmlh
IGtvcnp5c3RhIGp1xbwgcG9uYWQgNDkgdHlzLiBLbGllbnTDs3cuIE1vbml0b3J1amVteSA4MDkg
MDAwIHBvamF6ZMOzdyBuYSBjYcWCeW0gxZt3aWVjaWUsIGNvIGplc3QgbmFzesSFIG5hamxlcHN6
xIUgd2l6eXTDs3drxIUuCgpCYXJkem8gcHJvc3rEmSBvIGUtbWFpbGEgendyb3RuZWdvLCBqZcWb
bGkgbW9nbGliecWbbXkgd3Nww7NsbmllIG9tw7N3acSHIHBvdGVuY2phxYIgd3lrb3J6eXN0YW5p
YSB0YWtpZWdvIHJvendpxIV6YW5pYSB3IFBhxYRzdHdhIGZpcm1pZS4KCgpQb3pkcmF3aWFtLApQ
YXdlxYIgS2FtaWVuaWVja2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
