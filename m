Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MgDNC-0001MS-Re
	for kexec@lists.infradead.org; Wed, 26 Aug 2009 07:56:55 +0000
Received: by ywh5 with SMTP id 5so4853133ywh.13
	for <kexec@lists.infradead.org>; Wed, 26 Aug 2009 00:56:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090826063117.GB18761@verge.net.au>
References: <aec7e5c30908200614j68c1ad6ci7a3d8d1b9f98d08b@mail.gmail.com>
	<20090826063117.GB18761@verge.net.au>
Date: Wed, 26 Aug 2009 16:56:49 +0900
Message-ID: <aec7e5c30908260056w629fb2fp4be4c8660860f1c4@mail.gmail.com>
Subject: Re: kexec-tools-2.0.1 and CFLAGS
From: Magnus Damm <magnus.damm@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hi Simon!

On Wed, Aug 26, 2009 at 3:31 PM, Simon Horman<horms@verge.net.au> wrote:
> On Thu, Aug 20, 2009 at 10:14:19PM +0900, Magnus Damm wrote:
>> Kexec-tools 2.0.1 seems to build only with optimization enabled. If I
>> set CFLAGS before calling configure and remove the "-O2" then the code
>> won't link properly. I found it while cross compiling for SuperH, but
>> it's most likely an issue on other platforms as well. Have a look at
>> the "-O0" below:
>>
>> =A0$ AR=3D_ar CC=3D_gcc CFLAGS=3D"-O0" LDFLAGS=3D"-static" ./configure
>> --prefix=3D/ --host=3D"sh3-linux" --without-zlib --without-xen

[snip]

>> This issue is most likely related to get_unaligned() and
>> put_unaligned() having bad_unaligned_access_length() in their default
>> case that never gets optimized away.
>>
>> Anyway, not very important. But at least you know now. =3D)
>
> Hi Magnus,
>
> I'm some what dubious about this, but it appears to be intentional that
> get_unaligned() doesn't exist:
>
> ---- From kexec/kexec.h ----
>
> /*
> =A0* This function doesn't actually exist. =A0The idea is that when someo=
ne
> =A0* uses the macros below with an unsupported size (datatype), the linker
> =A0* will alert us to the problem via an unresolved reference error.
> =A0*/

Yes, I understand the purpose of the code and it makes sense. But the
data size in this case _is_ correct. The issue here seems to be that
the compiler is not optimizing away the default case reference unless
optimization is enabled. I'd suggest moving away from automatic type
size detection to have separate functions for each size. That would
make it possible to comple the code both with and without optimization
enabled.

Or may I'm misunderstanding the issue? =3D)

Cheers,

/ magnus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
