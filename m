Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA457C001DE
	for <kexec@archiver.kernel.org>; Fri, 28 Jul 2023 08:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hEwk9emYV/JTdG76nDJEYqXIam8UbOmZZZc27mIVi8c=; b=c7EzngqO0VKHdr
	/DsVJBEtZyUC7tcqdOad85x3VK4Nu3O8moDBh/lygmCN/VlUAVm3iUG5f2ddD9dYg3APtOiByHTWd
	qjx/bMqAz6rCYiNIUPHqWMBuJPTSn99GKfnKJsG5oOR5NNj1lC051jtRGK1vDsGUYl/ye+SyfPdqT
	L+GiC460f8jcUHal1fvRGup1OLrZqxrCr1NcvHfdMGcxeJ3cmkSHeko+WkdlpM96B2Qe+q+iN2Z3h
	V/JvwuTujtcPvvXf9PmBkckXujHDqf8UdydvGfGaQOwHpHT6bIQEDUWJdVIar1YPEqRsqYDeURek7
	GJnYeR2PopXjxN6zRznA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qPIVu-002KJs-33;
	Fri, 28 Jul 2023 08:07:54 +0000
Received: from mail.alsdel.com ([135.125.191.231])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qPIVq-002KGb-2u
	for kexec@lists.infradead.org;
	Fri, 28 Jul 2023 08:07:53 +0000
Received: by mail.alsdel.com (Postfix, from userid 1002)
	id 19CEE48F54; Fri, 28 Jul 2023 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsdel.com; s=mail;
	t=1690531610; bh=CAYDwZmm9N5ZiJT6ScYnRcZJNRz0YmzbvUPtJS3sV08=;
	h=Date:From:To:Subject:From;
	b=EL4F1V6RoFi0imvgqFZU/imkPrQ8Ny5Ut6Hlo4iYIBf5BXhxdJRnbdFWW2X3TXPBW
	 8ofgl9Q58ZdvaPIQk8Ysmi0TNRlBYaJU5Z3sLTO68Q7FWUWgWBFZRtJc21JqrF6eOx
	 P5LWcj2ZDMJbLvRYEJ1rXoORGKdXACPZxGKVYW4goIjVG/F86nFXxHJC2j1RyZda58
	 WXK0dYFIcSyBy83dJHLEA+NZQcpw3fBLPItsEwq6ZtapRgPIzR4qes/Zx3UEoOzguJ
	 3HPKzHgzOl+86n+/8EXN3MQ4Yg+8uSOIcozciAfHpmkDHI39dzLj7wvepUOrtTqbUZ
	 3FTHOF4CTwugg==
Received: by alsdel.com for <kexec@lists.infradead.org>; Fri, 28 Jul 2023 08:05:43 GMT
Message-ID: <20230728064520-0.1.1h.7wr8.0.027jpjt0xz@alsdel.com>
Date: Fri, 28 Jul 2023 08:05:43 GMT
From: "Marek Brzyski" <marek.brzyski@alsdel.com>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Magazyny_do_wynaj=C4=99cia_w_Twoim_regionie?=
X-Mailer: mail.alsdel.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230728_010751_722556_FC6045AE 
X-CRM114-Status: UNSURE (   0.60  )
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

RHppZcWEIGRvYnJ5LAoKbWFteSBkbGEgUGHFhHN0d2EgZG8gemFvZmVyb3dhbmlhIHd5bmFqZW0g
cG93aWVyemNobmkgbWFnYXp5bm93by1wcm9kdWtjeWpuZWogeiBkb3N0xJlwbnltaSBtb2R1xYJh
bWkgb2QgMyA1MDAgbWt3IG5hIGtvbmt1cmVuY3lqbnljaCB3YXJ1bmthY2guCgpPZGRhamVteSBu
YWplbWNvbSBkbyB1xbx5dGt1IHBhcmsgbWFnYXp5bm93by1wcm9kdWtjeWpueSB6IHd5asSFdGtv
d28gYXRyYWtjeWpuxIUgbG9rYWxpemFjasSFICh6YXLDs3dubyBkbGEgcHJhY293bmlrw7N3LCBq
YWsgaSBLbGllbnTDs3cpIC0gcHJ6eSBnxYLDs3dueWNoIHN6bGFrYWNoIGtvbXVuaWthY3lqbnlj
aCwgeiBkb2dvZG55bSBkb2phemRlbSBkbyBkcsOzZyBrcmFqb3d5Y2gsIG9kcG93aWVkbmllaiBp
bmZyYXN0cnVrdHVyeSBvcmF6IGtvbXVuaWthY2ppIG1pZWpza2llai4KCkR6acSZa2kgd3lrb3J6
eXN0YW5pdSBub3dvY3plc255Y2ggc3RhbmRhcmTDs3cgdGVjaG5pY3pueWNoIGkgcHJvIGVrb2xv
Z2ljem55Y2ggbW9nxIUgUGHFhHN0d28gd3lnZW5lcm93YcSHIG9zemN6xJlkbm/Fm2NpIHcgenXF
vHljaXUgZW5lcmdpaSBzacSZZ2FqxIVjZSBuYXdldCBraWxrdWR6aWVzacSZY2l1IHByb2NlbnQu
CgpDaGPEhSBQYcWEc3R3byBwb3puYcSHIGRvc3TEmXBuZSBvcGNqZT8KCgpQb3pkcmF3aWFtIHNl
cmRlY3puaWUKTWFyZWsgQnJ6eXNraQpTYWxlcyBNYW5hZ2VyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
