Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdEIj-0003X7-My
 for kexec@lists.infradead.org; Mon, 04 Nov 2013 07:10:19 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E785D3EE0BD
 for <kexec@lists.infradead.org>; Mon,  4 Nov 2013 16:09:48 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id D7D5445DE4E
 for <kexec@lists.infradead.org>; Mon,  4 Nov 2013 16:09:48 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C27C045DD77
 for <kexec@lists.infradead.org>; Mon,  4 Nov 2013 16:09:48 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id B582C1DB803E
 for <kexec@lists.infradead.org>; Mon,  4 Nov 2013 16:09:48 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 692891DB8037
 for <kexec@lists.infradead.org>; Mon,  4 Nov 2013 16:09:48 +0900 (JST)
Message-ID: <527747E2.3070405@jp.fujitsu.com>
Date: Mon, 04 Nov 2013 16:08:18 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022220803.GA32387@anatevka.fc.hp.com> <526712B2.7070108@jp.fujitsu.com>
 <20131031005812.GA15459@anatevka.fc.hp.com>
 <20131031132744.GB3392@redhat.com>
In-Reply-To: <20131031132744.GB3392@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jerry.hoemann@hp.com, bp@alien8.de, "Eric W. Biederman" <ebiederm@xmission.com>, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

(2013/10/31 22:27), Vivek Goyal wrote:
> On Wed, Oct 30, 2013 at 06:58:13PM -0600, jerry.hoemann@hp.com wrote:
>
> [..]
>> Daisuke,
>>
>> Are you planning on making changes to the kexec tools to automate
>> the setting of disable_cpu_apic to the capture kernel? Or do you
>> know someone who is planning this?
>
> I think we should not make this change in kexec-tools and should leave
> it to distro scripts to append disable_cpu_apic.
>
> Who knows in future this restriction is not there at all and kexec-tools
> will be stuck with always passing disable_cpu_apic. Getting rid of
> this parameter in distro scripts will be much easier.
>
> Thanks
> Vivek
>

Yes, I'll post the patch to distribution's kexec-tools. ``kexec-tools''
seems a little ambiguous; the users scripts on fedora are contained
in the same package.

I don't know things on other distributions mostly at all; I've read
Ubuntu's scripts really a little bit only. I'd like anyone to post patches
if necessary...

BTW, what's the status of this patch set? I've redesigned this so as to
be done with kernel parameter in order not to depend on platform specific
BIOS table. Due to the redesign, I think now ACK is needed again.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
