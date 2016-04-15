Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0063.outbound.protection.outlook.com ([157.56.110.63]
 helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqwvu-0008Ff-4d
 for kexec@lists.infradead.org; Fri, 15 Apr 2016 06:08:47 +0000
From: Hemanth Siddulugari <Hemanth.Siddulugari@nimblestorage.com>
Subject: Re: makedumpfile utility optimization
Date: Fri, 15 Apr 2016 06:08:20 +0000
Message-ID: <D335CCAA.2EDD7%hsiddulugari@nimblestorage.com>
References: <D33479A1.2ECC3%hsiddulugari@nimblestorage.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E3ACB9@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E3ACB9@BPXM01GP.gisp.nec.co.jp>
Content-Language: en-US
Content-ID: <831EA5C77BE4914DBAC456EF1F38AC08@nimblestorage.com>
MIME-Version: 1.0
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Atsushi,

Thanks a lot for a quick reply.

These results are on the following processor: E5504  @ 2.00GHz
We are running with SMP disabled (to be on the conservative side) so only
one CPU.
The dumpable pages were ~50000 out of 0x3c0000 (16G of RAM).
After dumping about 50000, it took more than 30 minutes to evaluate the
rest of the pages so our watchdog fired.
I put a print statement to print progress after processing every 10,000
pfns and I noticed that it was taking approximately 5 seconds to process
10,000 pfns (there must be something else going on that I=B9ll need to look
into).

Anyway, thanks for the confirmation that it is safe to use my patch.
Do you want me to commit my patch to the source of makedumpfile?

-Hemanth


On 4/14/16, 10:24 PM, "Atsushi Kumagai" <ats-kumagai@wm.jp.nec.com> wrote:

>(CC'ing kexec-ML)
>
>Hello Hemanth,
>
>>Hi 'makedumpfile' utility developers,
>>
>>I'm using version 1.5.6 and I see that we can optimize the utility using
>>this patch:
>>
>>--- makedumpfile-1.5.6/makedumpfile.c   2014-04-20 18:59:18.000000000
>>-0700
>>+++ makedumpfile-1.5.6-changed/makedumpfile.c   2016-04-11
>>18:47:50.019563738 -0700
>>@@ -6475,6 +6475,15 @@
>>
>>        for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
>>
>>+               /*
>>+                * There's no point in checking other pages if we've
>>already dumped
>>+                * all the pages that are dumpable
>>+                */
>>+               if (num_dumped =3D=3D info->num_dumpable) {
>>+                       ret =3D TRUE;
>>+                       goto out;
>>+               }
>>+
>>                if ((num_dumped % per) =3D=3D 0)
>>                        print_progress(PROGRESS_COPY, num_dumped,
>>info->num_dumpable);
>>
>>Why are we looping even after we are done with all the dumpable pages to
>>start with?
>>I'm concerned if I'm missing something with this patch.
>
>You are right, it's better to break the loop after the last dumpable page
>is written. I neglected that since the remains of loop just check the
>bitmap and call continue, I thought the wasteful processing cost is
>little.
>I'm curious to know how much does this patch improve the performance.
>
>
>Thanks,
>Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
