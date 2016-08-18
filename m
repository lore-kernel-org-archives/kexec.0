Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tex.lwn.net ([70.33.254.29] helo=vena.lwn.net)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1baQyM-0001RM-VS
 for kexec@lists.infradead.org; Thu, 18 Aug 2016 17:19:19 +0000
Date: Thu, 18 Aug 2016 11:18:54 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v9 1/2] Documentation: kdump: remind user of nr_cpus
Message-ID: <20160818111854.362bb972@lwn.net>
In-Reply-To: <1471489907-27737-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1471489907-27737-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1471489907-27737-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
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
To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, xlpang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, joe@perches.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

On Thu, 18 Aug 2016 11:11:46 +0800
Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com> wrote:

Thank you for working to improve the documentation!

>  * We generally don' have to bring up a SMP kernel just to capture the
>    dump. Hence generally it is useful either to build a UP dump-capture
>    kernel or specify maxcpus=1 option while loading dump-capture kernel.
> +  Note, though maxcpus always works, you should replace it by nr_cpus to
> +  save memory if supported by the current ARCH, such as x86.

So, IMHO, this seems like the wrong place for this.  I've just spent a bit
of time staring at kernel-parameters.txt, and there is no way for a
clueless user like me to know what the difference is between maxcpus= and
nr_cpus= would be.  A far better patch would be to update the
documentation there to make that clear.  Any chance you would be willing
to do that?

Then, rather than tacking an "ignore what you just read" note into
kdump.txt, it could maybe be rewritten to simply say what users should do?

Thanks,

jon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
