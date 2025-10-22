Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77A1CCD1AB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a/cxvjDIyLxcpAHODcE1I1yUn0aCZhf3T+hIgt770q8=; b=HWnYRBhbfsqkSg7gEJZ+YMvdP+
	3kk6prkYuwpsjRRxWNAFH+nHvNGiv+ZVsAkB4dlLG540dzFuleLuWXYnNADglROOvQiwb4ZMu3KND
	N0fafAnVlIqyhPrjS7Se3RxWAW1EyQD6GT74Ao0/2z74PUr9ZmXd4Ss+mTabFReV1zHYTlCrB5vqD
	RhCcrm1ypWaavSZOqDhytqknSfXEXRbJwA0MY1n52IS0BRaFTRNNzTehmsZHh9mxu/0GAMx9jwRoN
	PVgiCUduc0uRSSHgdtvI9iYDNfadPXfv677Ygbq3QSKMx9ONfOfvVQscOnWA1Rc0kyU0DqTyEppno
	da2jdd8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBadk-00000003Myy-3nSg;
	Wed, 22 Oct 2025 15:20:40 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBadh-00000003MxL-45hj
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 15:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=a/cxvjDIyLxcpAHODcE1I1yUn0aCZhf3T+hIgt770q8=; t=1761146438;
	x=1761751238; b=YivkZ2pSJZZSAbuhvQQmIG/rBI1ituYLsiye1aRgIwa24brzEIxU/IRU20f7U
	OeMwcnQ/TNKd/l/szpXsN45MNr/uFWF4T7ON1Prrqss/zfnxR1NyU+a2L+qt+Tvm9GODWyDL40Fuf
	arjVjYLebHLM3MVAKOg3CiHEvY2yCzuubnK9moqj7r7vzXnB+WYTz4AJ7NBsi4pmbHCn5RVqbO8PT
	f4FR2xmekZ6RqS+HcO1Jkf0soBNbV99TFQv43JP/JvK73Qwu2i7rmK/UL82vx9c6BltCgPcsPKqeK
	GUNqABhOLnZm2PHNl7WxtYZmaxBWZsgoMNrSO2UANr239Lsl+g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vBadf-00000000sYE-2xrR; Wed, 22 Oct 2025 17:20:35 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vBadf-00000000MEa-2F6p; Wed, 22 Oct 2025 17:20:35 +0200
Message-ID: <145b0eb54dd6548e19e22f230ebfca8cedee7e17.camel@physik.fu-berlin.de>
Subject: Re: [Spam] [PATCH 1/2] kexec-tools: powerpc: Fix function signature
 of comparefunc()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: khalid@gonehiking.org
Cc: kexec@lists.infradead.org
Date: Wed, 22 Oct 2025 17:20:35 +0200
In-Reply-To: <14f8d5e9-716b-413f-a6a9-da6b4f024a09@gonehiking.org>
References: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
	 <14f8d5e9-716b-413f-a6a9-da6b4f024a09@gonehiking.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.170.52
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_082038_387504_7C925FDC 
X-CRM114-Status: GOOD (  19.01  )
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

Hi Khalid,

On Wed, 2025-10-22 at 09:15 -0600, Khalid Aziz wrote:
> On 10/22/25 5:44 AM, John Paul Adrian Glaubitz wrote:
> > Fixes the following build error on 32-bit PowerPC:
> >=20
> > kexec/arch/ppc/fs2dt.c: In function 'putnode':
> > kexec/arch/ppc/fs2dt.c:338:51: error: passing argument 4 of 'scandir' f=
rom incompatible pointer type [-Wincompatible-pointer-types]
> >    338 |         numlist =3D scandir(pathname, &namelist, 0, comparefun=
c);
> >        |                                                   ^~~~~~~~~~~
> >        |                                                   |
> >        |                                                   int (*)(cons=
t void *, const void *)
> >=20
> > Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>=20
> I sent out a suggested patch yesterday making these same changes. They ma=
ke sense to me.

Yes, I actually saw your patch after submitting my patches. ;-)

> > ---
> >   kexec/arch/ppc/fs2dt.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
> > index fed499b..d03b995 100644
> > --- a/kexec/arch/ppc/fs2dt.c
> > +++ b/kexec/arch/ppc/fs2dt.c
> > @@ -292,7 +292,8 @@ static void putprops(char *fn, struct dirent **nlis=
t, int numlist)
> >    * Compare function used to sort the device-tree directories
> >    * This function will be passed to scandir.
> >    */
> > -static int comparefunc(const void *dentry1, const void *dentry2)
> > +static int comparefunc(const struct dirent **dentry1,
> > +		       const struct dirent **dentry2)
> >   {
> >   	char *str1 =3D (*(struct dirent **)dentry1)->d_name;
> >   	char *str2 =3D (*(struct dirent **)dentry2)->d_name;
>=20
> You can drop typecasting in above two lines as well:
>=20
> -    char *str1 =3D (*(struct dirent **)dentry1)->d_name;
> -    char *str2 =3D (*(struct dirent **)dentry2)->d_name;
> +    char *str1 =3D (*dentry1)->d_name;
> +    char *str2 =3D (*dentry2)->d_name;

That's right. However, that should be done in a separate patch which would
also do the same for comparefunc() in kexec/fs2dt.c so that changes that
logically belong together are submitted as one patch.

My changes above are the minimal changes required to fix the build on 32-bi=
t
PowerPC which I tested on the Debian powerpc/ppc64 porterbox.

Once the two patches are merged, I'm happy to submit one to drop the two
type-casting changes in both instances of comparefunc().

There are also some warnings that I will look into and address them.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

