Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X2giJ-0005R4-2W
 for kexec@lists.infradead.org; Thu, 03 Jul 2014 13:06:11 +0000
Received: from 40.77.194.77.rev.sfr.net ([77.194.77.40] helo=[192.168.1.20])
 by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1X2ght-0005cJ-Kh
 for kexec@lists.infradead.org; Thu, 03 Jul 2014 13:05:45 +0000
Message-ID: <53B554ED.2020808@ubuntu.com>
Date: Thu, 03 Jul 2014 15:04:45 +0200
From: Louis Bouchard <louis.bouchard@ubuntu.com>
MIME-Version: 1.0
Subject: Re: makedumpfile and elfutils
References: <007BD92917A2324FA403BCF9A464CF845CBC0690@ALA-MBB.corp.ad.wrs.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723B871@BPXM01GP.gisp.nec.co.jp>
 <20140703144246.6d1cd5ca@hananiah.suse.cz>
In-Reply-To: <20140703144246.6d1cd5ca@hananiah.suse.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

Le 03/07/2014 14:42, Petr Tesarik a =E9crit :
> On Thu, 3 Jul 2014 00:16:04 +0000
> Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> =

>> Hello Joe,
>>
>>> I am updating a bitbake recipe to build makedumpfile 1.5.6.  The current
>>> recipe builds 1.4.4 and includes a version of elfutils.  For 1.5.6 you =
say
>>> to use elfutils-0.142 but we already have version 0.158 so I don't see =
why
>>> we should need an older version, too.  makedumpfile builds linking to
>>> elfutils-0.158.
>>>
>>>
>>>
>>> Do we really need elfutils-0.142?
>>
>> No, 0.142 or later are OK, you don't need to downgrade it.
>> However, I didn't test the recent versions of elfutils, so please let me
>> know if you find any problems.
> =

> For the record, makedumpfile linked against 0.158 has now been
> extensively tested during the development of SUSE Linux Enterprise 12.
> No problems found whatsoever. ;-)
> =

> Petr Tesarik
> =


0.158 is in use in Ubuntu 14.04 Trusty. Debian Jessie & Unstable both use 0=
.159
and I haven't heard any issue on my side either.

Kind regards,

...Louis


-- =

Louis Bouchard
Software engineer,
Ubuntu
GPG : 429D 7A3B DD05 B6F8 AF63  B9C4 8B3D 867C 823E 7A61

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
