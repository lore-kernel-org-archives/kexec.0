Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TKFy1-00053O-UH
 for kexec@lists.infradead.org; Fri, 05 Oct 2012 22:01:58 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1348991844-12285-1-git-send-email-yinghai@kernel.org>
 <1348991844-12285-5-git-send-email-yinghai@kernel.org>
 <alpine.DEB.2.02.1210011139320.29232@kaball.uk.xensource.com>
 <20121003165105.GA30214@jshin-Toonie>
 <CAE9FiQW7vcwSUen_TD8tZQd6aDU2-on5_T4Bjr6aqN1bxM_5Cg@mail.gmail.com>
 <20121004164630.GB2244@phenom.dumpdata.com>
 <CAE9FiQUBohwjOzOm26yJME=JzZ7eH55hM+Q=Kc4Pz+ocaw90Jg@mail.gmail.com>
 <871uhcsk93.fsf@xmission.com>
 <CAE9FiQVx93B_imGbs1ms7gcu_-Z9HvkcGePQi9XpWQo0SKu-Kg@mail.gmail.com>
 <87ehlcr4et.fsf@xmission.com>
 <CAE9FiQU_PSv6afXLcQ8ohrn1wqoVttO+u5MA5xBEE4jJRVx9Mw@mail.gmail.com>
 <877gr4r40b.fsf@xmission.com>
 <CAE9FiQUW3uvkooBxqEdSxV7T8h4=5qonoLbJCPGT0kTceqSNRw@mail.gmail.com>
Date: Fri, 05 Oct 2012 15:01:26 -0700
In-Reply-To: <CAE9FiQUW3uvkooBxqEdSxV7T8h4=5qonoLbJCPGT0kTceqSNRw@mail.gmail.com>
 (Yinghai Lu's message of "Fri, 5 Oct 2012 14:43:57 -0700")
Message-ID: <87obkgpoi1.fsf_-_@xmission.com>
MIME-Version: 1.0
Subject: 896MB address limit (was: Re: [PATCH 04/13] x86,
 mm: Revert back good_end setting for 64bit)
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>, kexec@lists.infradead.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jacob Shin <jacob.shin@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cliff Wickman <cpw@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>


I am going to see about merging these two threads.

Yinghai Lu <yinghai@kernel.org> writes:

> On Fri, Oct 5, 2012 at 2:41 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Yinghai Lu <yinghai@kernel.org> writes:
>>
>>> with bzImage or vmlinux?
>>
>> bzImage I presume.  Certainly the bzImage has lost it's 896M limit,
>> which is where ultimiately the 896M limite came from.
>
> they are using updated kexec-tools ?
>
> last time when i checked the code for kexec-tools
> found the 896M problem was from kexec-tools bzimage support.

Cliff Wickman was the guy at sgi running the tests.

To the best of my knowledge he was runing an up to date kexec-tools and
was loading a bzImage.  Of course his initial reaction was where did the
896M limit come from, as he had just updated to a kernel with the limit
a few weeks ago.

YH please talk to Cliff directly.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
