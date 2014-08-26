Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XMGW5-0001fW-0T
 for kexec@lists.infradead.org; Tue, 26 Aug 2014 13:10:30 +0000
Date: Tue, 26 Aug 2014 09:10:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 8/8] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140826131006.GB9081@redhat.com>
References: <1408937592-2609-1-git-send-email-bhe@redhat.com>
 <1408937592-2609-9-git-send-email-bhe@redhat.com>
 <20140825063622.GB1501@dhcp-16-105.nay.redhat.com>
 <20140825200418.GK14379@redhat.com>
 <20140826063709.GC15032@dhcp-16-116.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140826063709.GC15032@dhcp-16-116.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On Tue, Aug 26, 2014 at 02:37:09PM +0800, Baoquan He wrote:
> On 08/25/14 at 04:04pm, Vivek Goyal wrote:
> > On Mon, Aug 25, 2014 at 02:36:22PM +0800, Baoquan He wrote:
>  
> > > The print is like below:
> > > 
> > > ~$ ./makedumpfile --mem-usage /proc/kcore
> > > The kernel version is not supported.
> > > The created dumpfile may be incomplete.
> > 
> > I still think that above messages should go. It does not make
> > any sense with --mem-usage. No dumpfile is being created here.
> 
> This is printed by function get_kernel_version(), it will be used by
> other makedumpfile main code flows too. This message is used to warn
> users that users' using kernel may not be tested suffciently. I think
> those tests are mainly taken by Atsushi. When he finished sufficient
> tests on a new version of kernel, the LATEST_VERSION will be changed to
> be a larger value. I am fine with this message, since it won't occur on
> our distribution, anyway kernel for distribution are all tested. And if
> LATEST_VERSION is older than our distribution kernel, maintainer may be
> pushed to take tests and update this value. So don't worry about this
> message.
> 
> But I would like to change the message like below to clean up
> misunderstanding if Atsushi doesn't object, this mostly occur when
> people working on latest upstream kernel.
> -------------------------------------------------
> The kernel version is not supported.
> The makedumpfile operation may not be successful.
> --------------------------------------------------

I think you might have to create a gloabl variable somewhere which tells
what mode makedumpfile is operating in. And messages might have to be
changed accordingly.

In this case, I think a single line of following message might be
sufficient.

"Warning: This kernel version is not supported."

[..]
> > > 
> > > makedumpfile Completed.
> > 
> > We don't need above line either.
> 
> This is also a public message printing, means if makedumpfile operation
> is successful or not. Maybe I can add a check like below:

Generally commands return code either "0" or "1" to designate success
or failure. And they don't display to user whether they succeeded or
failed.

> 
> @@ -9546,7 +9553,7 @@ main(int argc, char *argv[])
>         retcd = COMPLETED;
>  out:
>         MSG("\n");
> -       if (retcd == COMPLETED)
> +       if ((retcd == COMPLETED) && (!info->flag_mem_usage))
>                 MSG("makedumpfile Completed.\n");
>         else
>                 MSG("makedumpfile Failed.\n");

I think this will work. This will display failure message but in case
of success only table is displayed.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
