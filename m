Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SF1zs-00029b-Lh
 for kexec@lists.infradead.org; Tue, 03 Apr 2012 11:34:02 +0000
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Tue, 3 Apr 2012 07:33:59 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0C4226E804C
 for <kexec@lists.infradead.org>; Tue,  3 Apr 2012 07:33:38 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q33BXbtY311430
 for <kexec@lists.infradead.org>; Tue, 3 Apr 2012 07:33:37 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q33BY2O0030132
 for <kexec@lists.infradead.org>; Tue, 3 Apr 2012 05:34:03 -0600
Message-ID: <4F7AE00C.1040607@linux.vnet.ibm.com>
Date: Tue, 03 Apr 2012 17:03:32 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: Fwd: Re: makedumpfile security key enhancement using SIAL
References: <4F6870DD.6060102@linux.vnet.ibm.com>
 <20120321154328.4bbcff7d.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F6B60C6.7060707@linux.vnet.ibm.com>
 <20120330120200.04bcde45.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120330120200.04bcde45.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, lucchouina@yahoo.com, anderson@redhat.com, Reinhard Buendgen <buendgen@de.ibm.com>

Hello Kumagai-san,

On Friday 30 March 2012 08:32 AM, Atsushi Kumagai wrote:
> Hello Aravinda,
>
> On Thu, 22 Mar 2012 22:56:30 +0530
> Aravinda Prasad<aravinda@linux.vnet.ibm.com>  wrote:
>
>> On Wednesday 21 March 2012 12:13 PM, Atsushi Kumagai wrote:
>>> Hello Aravinda,
>>>
>>> I have two questions, could you answer me ?
>>>
>>> First, what problems do you have about the current format of makedumpfile.conf ?
>>
>> Even though makedumpfile.conf is capable of filtering out data from the
>> vmocore, it is not possible to specify and erase complex
>> data-structures. For example it is not possible to traverse a nested
>> list or a tree and then erase a particular node based on some
>> conditions. Extending makedumpfile.conf to support these would require
>> implementing a lot of language constructs. But we can reuse SIAL
>> instead of extending makedumpfile.conf.
>>
>>> Second, what benefits do you expect from using SIAL ? I can't imagine
>>> specific benefits with using SIAL now.
>>
>> SIAL can be used as a language construct to specify rules/commands to
>> erase data in the image file. The makedumpfile would interpret the
>> rules/commands provided by SIAL macros with the help of SIAL library
>> and would suitably erase the required data in the dump file. As SIAL
>> provides a lot of language constructs like conditional statements,
>> logical and arithmetic operators, nested loops, functions etc, it would
>> be possible to traverse nested lists and trees and conditionally erase
>> data in the dump file, enabling users to literally erase any data in
>> the dump file.
>
> Thank you for your explanation.
> It seems good to specify rules with SIAL.
>
> If makedumpfile uses SIAL library, I will discard the current format of
> makedumpfile.conf to reduce the size of source code.
> What do you think about it ?
>

I will come up with a prototype for integrating SIAL with makedumpfile
and then we can discuss whether to discard the existing
makedumpfile.conf format or not. Because the planned makedumpfile
enhancement with SIAL could use some infrastructure provided by
existing implementation like code to erase data in dump file and also
the makedumpfile.conf file can be used to specify SIAL macros.

Regards,
Aravinda

>
> Thanks
> Atsushi Kumagai
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
