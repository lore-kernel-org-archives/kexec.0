Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SAlmh-00053t-Py
 for kexec@lists.infradead.org; Thu, 22 Mar 2012 17:26:49 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 22 Mar 2012 13:26:41 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B7A0038C8069
 for <kexec@lists.infradead.org>; Thu, 22 Mar 2012 13:26:37 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2MHQZH9247584
 for <kexec@lists.infradead.org>; Thu, 22 Mar 2012 13:26:35 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2MHQYSq023348
 for <kexec@lists.infradead.org>; Thu, 22 Mar 2012 14:26:34 -0300
Message-ID: <4F6B60C6.7060707@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2012 22:56:30 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: Fwd: Re: makedumpfile security key enhancement using SIAL
References: <4F6870DD.6060102@linux.vnet.ibm.com>
 <20120321154328.4bbcff7d.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120321154328.4bbcff7d.kumagai-atsushi@mxc.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, lucchouina@yahoo.com, anderson@redhat.com

On Wednesday 21 March 2012 12:13 PM, Atsushi Kumagai wrote:
> Hello Aravinda,
>
> I have two questions, could you answer me ?
>
> First, what problems do you have about the current format of makedumpfile.conf ?

Even though makedumpfile.conf is capable of filtering out data from the
vmocore, it is not possible to specify and erase complex
data-structures. For example it is not possible to traverse a nested
list or a tree and then erase a particular node based on some
conditions. Extending makedumpfile.conf to support these would require
implementing a lot of language constructs. But we can reuse SIAL
instead of extending makedumpfile.conf.

> Second, what benefits do you expect from using SIAL ? I can't imagine
> specific benefits with using SIAL now.

SIAL can be used as a language construct to specify rules/commands to
erase data in the image file. The makedumpfile would interpret the
rules/commands provided by SIAL macros with the help of SIAL library
and would suitably erase the required data in the dump file. As SIAL
provides a lot of language constructs like conditional statements,
logical and arithmetic operators, nested loops, functions etc, it would
be possible to traverse nested lists and trees and conditionally erase
data in the dump file, enabling users to literally erase any data in
the dump file.

>
> By the way, could you add kexec-ML to CC field from next time ?

Included.

>
>    kexec mailing list:
>      kexec@lists.infradead.org
>      http://lists.infradead.org/mailman/listinfo/kexec
>
>
> Thanks
> Atsushi Kumagai
>
>
> On Tue, 20 Mar 2012 17:28:21 +0530
> Aravinda Prasad<aravinda@linux.vnet.ibm.com>  wrote:
>
>> Hi Luc,
>>
>> We are looking for utilising SIAL as a language construct for the
>> makedumpfile kernel data filtering from vmcore feature. The details of
>> which are in the mail forward.
>>
>> The proposed enhancement will require libsial.a and as SIAL is not
>> currently built/shipped, we are looking for possibilities on how
>> libsial.a can be made available to makedumpfile. Please let us know your
>> opinion on the same.
>>
>> Regards,
>> Aravinda
>>
>>
>> -------- Original Message --------
>> Subject: Re: makedumpfile security key enhancement using SIAL
>> Date: Tue, 13 Mar 2012 10:27:43 -0400 (EDT)
>> From: Dave Anderson<anderson@redhat.com>
>> To: Aravinda Prasad<aravinda@linux.vnet.ibm.com>
>> CC: Atsushi Kumagai<kumagai-atsushi@mxc.nes.nec.co.jp>,         Masaki
>> Tachibana<tachibana@mxm.nes.nec.co.jp>,        Ananth N
>> Mavinakayanahalli<ananth@in.ibm.com>,        Mahesh J Salgaonkar
>> <mahesh@linux.vnet.ibm.com>
>>
>>
>>
>> ----- Original Message -----
>>> Hi Dave,
>>>
>>> Last year, we worked on the makedumpfile security key filtering where we
>>> added support to filter out kernel data from vmcore. This year, we are
>>> working on enhancing the framework to provide more flexibility for the
>>> customers to specify rules to traverse and filter out kernel data - for
>>> which we are planning to use SIAL.
>>>
>>> We are looking into using SIAL as language construct to specify
>>> rules/commands to erase data in the image file. The makedumpfile would
>>> interpret the rules provided in SIAL macro using SIAL library (which
>>> could be dynamically loaded) and erase out suitable data in the vmcore.
>>> We are planning to reuse SIAL as it provides a C language like
>>> construct, which is flexible and powerful enough to specify rules to
>>> erase data in vmcore.
>>>
>>> As SIAL is not built and shipped along with crash, we are looking for
>>> possibilities on how SIAL can be leveraged by makedumpfile and would
>>> like to know your opinion.
>>
>> Sorry but I cannot give you any help with SIAL.  Luc Chouinard is the
>> maintainer of the SIAL extension module adaptation for the crash utility,
>> and he can answer your questions w/respect to adapting it for makedumpfile.
>> And ultimately, that's a question for the makedumpfile maintainers.
>>
>> Dave
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
