Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XNIfA-0001yv-GG
 for kexec@lists.infradead.org; Fri, 29 Aug 2014 09:40:09 +0000
Date: Fri, 29 Aug 2014 17:37:46 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v5 8/8] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140829093746.GA1810@dhcp-16-105.nay.redhat.com>
References: <1408937592-2609-1-git-send-email-bhe@redhat.com>
 <1408937592-2609-9-git-send-email-bhe@redhat.com>
 <20140825063622.GB1501@dhcp-16-105.nay.redhat.com>
 <20140825200418.GK14379@redhat.com>
 <20140826063709.GC15032@dhcp-16-116.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97250016@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97250016@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/27/14 at 12:32am, Atsushi Kumagai wrote:

> >This is printed by function get_kernel_version(), it will be used by
> >other makedumpfile main code flows too. This message is used to warn
> >users that users' using kernel may not be tested suffciently. I think
> >those tests are mainly taken by Atsushi. When he finished sufficient
> >tests on a new version of kernel, the LATEST_VERSION will be changed to
> >be a larger value. I am fine with this message, since it won't occur on
> >our distribution, anyway kernel for distribution are all tested. And if
> >LATEST_VERSION is older than our distribution kernel, maintainer may be
> >pushed to take tests and update this value. So don't worry about this
> >message.
> >
> >But I would like to change the message like below to clean up
> >misunderstanding if Atsushi doesn't object, this mostly occur when
> >people working on latest upstream kernel.
> >-------------------------------------------------
> >The kernel version is not supported.
> >The makedumpfile operation may not be successful.
> >--------------------------------------------------
> 
> Good change, let's do it. --mem-usage doesn't create a dumpfile
> but the behavior still depend on the kernel version, this message
> is meaningful. Also, as Vivek said, the latter line can be
> changed based on the operating mode, but I don't think it's
> necessary.

OK, I would like to change the printing message for now. If necessary,
I prefer to post a independent cleanup patch for message printing.

> 
> >>

> >This is also a public message printing, means if makedumpfile operation
> >is successful or not. Maybe I can add a check like below:
> >
> >@@ -9546,7 +9553,7 @@ main(int argc, char *argv[])
> >        retcd = COMPLETED;
> > out:
> >        MSG("\n");
> >-       if (retcd == COMPLETED)
> >+       if ((retcd == COMPLETED) && (!info->flag_mem_usage))
> >                MSG("makedumpfile Completed.\n");
> >        else
> >                MSG("makedumpfile Failed.\n");
> 
> This code always show "makedumpfile Failed" for --mem-usage :-)
> 
> Anyway,
> 
> >Hi Atsushi,
> >
> >How do you think about this? And for the excluding progress indication
> >too, add a check that if it's mem-usage handling, not printing.
> 
> I don't think we need to change the both messages, they indicate
> the actual progress and result even in the mem-usage mode.

OK, so just keep it in this patchset. 

Thanks for suggestion.

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
