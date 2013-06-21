Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UppIi-0004lK-S7
 for kexec@lists.infradead.org; Fri, 21 Jun 2013 00:34:06 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id B3E3F3EE0BC
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 09:33:33 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id A1EF845DE53
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 09:33:33 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8191945DE4E
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 09:33:33 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 755021DB802F
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 09:33:33 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1C43F1DB8037
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 09:33:33 +0900 (JST)
Message-ID: <51C39F2C.6090002@jp.fujitsu.com>
Date: Fri, 21 Jun 2013 09:32:44 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: add missing options to man page or help
References: <fc047066a6f5ba18f02838f4b3e89006917db4a5.1371632010.git.bhe@redhat.com>
 <51C24656.1080509@jp.fujitsu.com> <51C28E41.2080903@redhat.com>
 <20130620154334.33a09ca47ec66a1c834db08e@mxc.nes.nec.co.jp>
In-Reply-To: <20130620154334.33a09ca47ec66a1c834db08e@mxc.nes.nec.co.jp>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, bhe@redhat.com

(2013/06/20 15:43), Atsushi Kumagai wrote:
> Hello Baoquan and HATAYAMA-san,
>
> On Thu, 20 Jun 2013 13:08:17 +0800
> Baoquan <bhe@redhat.com> wrote:
>
>> On 06/20/2013 08:01 AM, HATAYAMA Daisuke wrote:
>>
>>>
>>>> makedumpfile has some options which has two 2 forms, long option
>>>> and short option. E.g. --help  |  -h
>>>>
>>>> In man page and help, only one of them are presented, user may complain
>>>> of this. Here add missing options.
>>>>
>>>
>>> I guess the maintainer does so intentionally, I'm not sure of course.
>>> Characters for short options is limited resource, but now makedumpfile
>>> has considerably many options. We can no longer assign reasonable
>>> letters to each functionality with short options. For example, please
>>> look at the definition of longopts:
>
> That's right, some letters assigned to recent feature have no reason.
> So, they aren't suitable to be exported explicitly for users.
>
>>>
>>> static struct option longopts[] = {
>>>          {"split", no_argument, NULL, 's'},
>>>          {"reassemble", no_argument, NULL, 'r'},
>>>          {"xen-syms", required_argument, NULL, 'y'},
>>>          {"xen-vmcoreinfo", required_argument, NULL, 'z'},
>>>          {"xen_phys_start", required_argument, NULL, 'P'},
>>>          {"message-level", required_argument, NULL, 'm'},
>>>          {"vtop", required_argument, NULL, 'V'},
>>>          {"dump-dmesg", no_argument, NULL, 'M'},
>>>          {"config", required_argument, NULL, 'C'},
>>>          {"help", no_argument, NULL, 'h'},
>>>          {"diskset", required_argument, NULL, 'k'},
>>>          {"non-cyclic", no_argument, NULL, 'Y'},
>>>          {"cyclic-buffer", required_argument, NULL, 'Z'},
>>>          {"eppic", required_argument, NULL, 'S'},
>>>          {"map-size", required_argument, NULL, 'A'},
>>>          {0, 0, 0, 0}
>>> };
>>>
>>> I don't see any relationship on the last three options: non-cyclic vs Y,
>>> cyclic-buffer vs Z, eppic vs S and map-size vs A. I don't think there
>>> are users who use short options for these features.
>>
>>
>> Hi,
>>
>> Thanks for telling. I totally understand that unmarched letters between
>> long and short options are truly annoying. But like current code, only
>> presenting long options in man page and help may cause complaint from QA
>> or customers.
>>
>>>
>>> One of my solution is conversely to delete short options, and I don't
>>> think it problem because the short options are only implicitly exported
>>> without explicit description on such as manual page and help message.
>>
>>
>> Yeah, deleting short options is also a good method, let's wait and see
>> what the maintainer say.
>
> I agree to delete short options.
> Could you re-send the patch ?
>

BTW, we can assign non-printable characters as short options. Normally we don't type non-printable characters on console, so it's for free.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
