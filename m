Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9v12-0006Y9-OT
 for kexec@lists.infradead.org; Fri, 07 Sep 2012 09:38:22 +0000
Message-ID: <5049BFA9.4090107@redhat.com>
Date: Fri, 07 Sep 2012 17:34:33 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: Getting the kexec on panic
References: <20120906094336.GJ1943@vicerveza.homeunix.net>
 <20120906220651.GB1745@cantor.Home>
In-Reply-To: <20120906220651.GB1745@cantor.Home>
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
To: =?ISO-8859-1?Q?Llu=EDs_Batlle_i_Rossell?= <viric@viric.name>, kexec@lists.infradead.org

On 09/07/2012 06:06 AM, Jerry Snitselaar wrote:

> On Thu Sep 06 12, Llu=EDs Batlle i Rossell wrote:
>> Hello,
>>
>> while I can load immediately a kernel using kexec, when I set it for pan=
ic and
>> crash with sysrq-c, the computer hangs.
>>
>> I'm using the nvidia X driver; can it be that it stops the panic handlin=
g from
>> working? I don't understand why it would work with normal kexec though, =
if it
>> were the case.
>>
>> Regards,
>> Llu=EDs.
> =

> Hi Lluis,
> =

> =

> What kernel are you using? The commit 722bc6b "x86/mm: Fix the size calcu=
lation of mapping tables" which started showing up in 3.5-rc1 causes proble=
ms for the crash kernel. You might try this patchset[1] from Jacob Shin and=
 see if it resolves the problem for you if you are experiencing your proble=
m on a 3.5-rc1+ kernel.
> =

> [1] https://lkml.org/lkml/2012/8/24/474


He has updated the v5 patch set as below:
https://lkml.org/lkml/2012/8/29/227

> =

> Regards,
> Jerry
> =

>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



-- =

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
