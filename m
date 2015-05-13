Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.emea.novell.com ([130.57.118.101])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsVml-0005rs-V7
 for kexec@lists.infradead.org; Wed, 13 May 2015 12:29:16 +0000
Message-Id: <55535FA3020000780007A096@mail.emea.novell.com>
Date: Wed, 13 May 2015 13:28:51 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] More on kexec/purgatory handover
References: <20150509152159.6b391c2b@hananiah.suse.cz>
 <20150509152159.6b391c2b@hananiah.suse.cz>
 <87y4ktjbe8.fsf@x220.int.ebiederm.org>
 <5553116A0200007800079D2D@mail.emea.novell.com>
 <5553116A0200007800079D2D@mail.emea.novell.com>
 <87vbfxhquv.fsf@x220.int.ebiederm.org>
 <5553239F0200007800079DEE@mail.emea.novell.com>
 <55531F0F.4090603@citrix.com>
 <55533D140200007800079F25@mail.emea.novell.com>
 <20150513141214.7a2e454f@hananiah.suse.cz>
In-Reply-To: <20150513141214.7a2e454f@hananiah.suse.cz>
Mime-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org

>>> On 13.05.15 at 14:12, <ptesarik@suse.cz> wrote:
> On Wed, 13 May 2015 11:01:24 +0100
> "Jan Beulich" <JBeulich@suse.com> wrote:
>> Okay, if the tools do this in v2, then I think the compatibility v1
>> path should indeed do so too (in the hypervisor).
> 
> Are you working on a patch?

Not yet, but I'm going to as soon as I can find the time.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
