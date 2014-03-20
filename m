Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQfQy-0006Nz-OQ
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 16:03:09 +0000
Message-ID: <532B10F5.9010709@zytor.com>
Date: Thu, 20 Mar 2014 09:01:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] x86, calgary: use 8M TCE table size by default
References: <1394463120-26999-1-git-send-email-chaowang@redhat.com>
 <20140320155411.GC29549@redhat.com>
In-Reply-To: <20140320155411.GC29549@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Jon D. Mason" <jdmason@kudzu.us>, Muli Ben-Yehuda <muli@cs.technion.ac.il>, WANG Chao <chaowang@redhat.com>

On 03/20/2014 08:54 AM, Vivek Goyal wrote:
> Hi hpa,
> 
> I am wondering how to make progress on calgary issue now. We do want to
> cleanup kexec-tools code and move to passing memory ranges in bootparams.
> 
> I see two choices here.
> 
> - Take this patch in so that new kernel code will work with modified
>   kexec-tools without any user intervention. (Both first and second kernel
>   need to be new). 
> 
> - Don't take this patch in and calgary will be broken with new
>   kexec-tools. And that will always require manual user intervention
>   from user to force passing memmap on command line.
> 
> I kind of prefer the first option so that even if there are some calgary
> machines out there, they will work automatically with new kernel and
> will require manual intervention only for old kernels and new kexec-tool
> cobination.
> 
> But I can live with second option too if that's everybody agrees to and
> hopefully we don't get lots of reports of breaking kdump with kexec-tools
> upgrade.
> 

The patch seems simple enough and doesn't require any new command line
hacks.  It has been widely reviewed and acked, so I'll pick it up.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
