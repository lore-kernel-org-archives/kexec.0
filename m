Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CD4CFC52A
	for <kexec@archiver.kernel.org>; Sat, 22 Nov 2025 11:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hvUeBVD2w01WjC/2otfxCLUCPQp7UBR91pc5PJyyVZU=; b=wIKj1P6+N6Ii6QcI8vbRcc4Kyg
	7nA0XQidWlTe9pqpfu0QOTqCWrG4JY5T6fA2yUlOjjoJt4NIv6hPHSk8Vjf1hGRXbM0Np0ODQZUNY
	Ia3/ldYAP7+56jiEulqVBeabQ2GN/2D0VNXgPwcVxjSoDJEBRWH8MU46+3eOfzUFzlUM5l+K0FHzs
	+pRbf9kYoBbdaYnVorZNwluKhnwAgEBK7jDuHGspvUOvQcBUSsfPXbyq3+0/M2rsd6HteuIiCnEd4
	xIASzA7uzkPmz1NzRr6ULPAKhqHKLlhqTQOupzlJq/vtl4E/7BRpuuAQxMHT51OismFxVS8cQbmQN
	KfdH8LsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMlX4-00000009UIS-2vYG;
	Sat, 22 Nov 2025 11:11:58 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMlWz-00000009UI3-0WmH
	for kexec@lists.infradead.org;
	Sat, 22 Nov 2025 11:11:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=hvUeBVD2w01WjC/2otfxCLUCPQp7UBR91pc5PJyyVZU=; t=1763809913;
	x=1764414713; b=R0s/88dL56OzWyAYtSvdL+vJL3TPQaQkWAL71HXDIOqKL9uiShgZcFGjPveWQ
	0EQJa3RpvbTr3IOrlL+GvvFFhAgig8C/5yxM1R8fCmy4cpNd4nHsjVIgN3R/Ozgfu4BKS/EcR3fTT
	LdgD/n7t9TTBpFbBNQcszOojzVFIJ6BU0uhGHot3akGLT30wqWYCvXYqMr+qDBXejwGIg3wNVgwAs
	AwWgu73S89dpsmLxgZkhAYJpwQ/WGtcboOv5ipUABSpUGHioBkZFUGqJnnG1FipkW0XJNNpFMg0Se
	lSLn6NHUp1ZHvhc2ezc8c8BncwyyI/WQPpZ/qk0I90XBuV5jzA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vMlWt-00000002glF-3pxV; Sat, 22 Nov 2025 12:11:47 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vMlWt-00000001V0k-2x9A; Sat, 22 Nov 2025 12:11:47 +0100
Message-ID: <501429ee083aa7fb07db910e167411fa7707a0f6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] kexec-tools: powerpc: Fix function signature of
 comparefunc()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: kexec@lists.infradead.org
Cc: Khalid Aziz <khalid@gonehiking.org>
Date: Sat, 22 Nov 2025 12:11:47 +0100
In-Reply-To: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
References: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.170.52
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251122_031153_317403_70ABB017 
X-CRM114-Status: GOOD (  12.78  )
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

On Wed, 2025-10-22 at 13:44 +0200, John Paul Adrian Glaubitz wrote:
> Fixes the following build error on 32-bit PowerPC:
>=20
> kexec/arch/ppc/fs2dt.c: In function 'putnode':
> kexec/arch/ppc/fs2dt.c:338:51: error: passing argument 4 of 'scandir' fro=
m incompatible pointer type [-Wincompatible-pointer-types]
>   338 |         numlist =3D scandir(pathname, &namelist, 0, comparefunc);
>       |                                                   ^~~~~~~~~~~
>       |                                                   |
>       |                                                   int (*)(const v=
oid *, const void *)
>=20
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  kexec/arch/ppc/fs2dt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
> index fed499b..d03b995 100644
> --- a/kexec/arch/ppc/fs2dt.c
> +++ b/kexec/arch/ppc/fs2dt.c
> @@ -292,7 +292,8 @@ static void putprops(char *fn, struct dirent **nlist,=
 int numlist)
>   * Compare function used to sort the device-tree directories
>   * This function will be passed to scandir.
>   */
> -static int comparefunc(const void *dentry1, const void *dentry2)
> +static int comparefunc(const struct dirent **dentry1,
> +		       const struct dirent **dentry2)
>  {
>  	char *str1 =3D (*(struct dirent **)dentry1)->d_name;
>  	char *str2 =3D (*(struct dirent **)dentry2)->d_name;

Ping for both patches.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

