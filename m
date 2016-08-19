Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1baXmA-0000K0-45
 for kexec@lists.infradead.org; Fri, 19 Aug 2016 00:35:10 +0000
Message-ID: <57B653D1.8060106@cn.fujitsu.com>
Date: Fri, 19 Aug 2016 08:33:21 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/2] Documentation: kdump: remind user of nr_cpus
References: <1471489907-27737-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>	<1471489907-27737-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160818111854.362bb972@lwn.net>
In-Reply-To: <20160818111854.362bb972@lwn.net>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, xlpang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, joe@perches.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

Hi Jonathan,

Thanks for your reply.

On 08/19/2016 01:18 AM, Jonathan Corbet wrote:
> On Thu, 18 Aug 2016 11:11:46 +0800
> Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com> wrote:
>
> Thank you for working to improve the documentation!
>
>>   * We generally don' have to bring up a SMP kernel just to capture the
>>     dump. Hence generally it is useful either to build a UP dump-capture
>>     kernel or specify maxcpus=1 option while loading dump-capture kernel.
>> +  Note, though maxcpus always works, you should replace it by nr_cpus to
>> +  save memory if supported by the current ARCH, such as x86.
>
> So, IMHO, this seems like the wrong place for this.  I've just spent a bit
> of time staring at kernel-parameters.txt, and there is no way for a
> clueless user like me to know what the difference is between maxcpus= and
> nr_cpus= would be.  A far better patch would be to update the
> documentation there to make that clear.  Any chance you would be willing
> to do that?
>
> Then, rather than tacking an "ignore what you just read" note into
> kdump.txt, it could maybe be rewritten to simply say what users should do?
>

I was also confused by maxcpus and nr_cpus before writing this patch.
I think it is a good choice to describe it in kernel-parameters.txt.

Then, only two things need to be done I think.
One is move the above description to maxcpus= in kernel-parameters.txt.
And the other is replace maxcpus with maxcpus/nr_cpus in kdump.txt.

How do you think?

-- 
Thanks
Zhou



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
