Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WiPRw-0000jn-VF
 for kexec@lists.infradead.org; Thu, 08 May 2014 14:37:29 +0000
Date: Thu, 8 May 2014 22:37:04 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH RESEND] condition check fix
Message-ID: <20140508143704.GA6852@dhcp12-158.nay.redhat.com>
References: <1399548377-10417-1-git-send-email-chaowang@redhat.com>
 <20140508141429.GD9224@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140508141429.GD9224@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 05/08/14 at 10:14am, Vivek Goyal wrote:
> On Thu, May 08, 2014 at 07:26:17PM +0800, WANG Chao wrote:
> > In commit 91f5b9c ("kdump: pass e820 reserved region to 2nd kernel via
> > e820 table or setup_data"), I made a wrong condition check.
> > 
> > We should only add cmdline for a memory range if --pass-memmap-cmdline
> > and the range type isn't RANGE_RESERVED.
> > 
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> 
> Ok, this fixes the issue for me. Thanks.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>
> 
> BTW, on a related note, I see that we are doing GART check two times.
> 
>                 } else if (memcmp(str, "GART\n", 5) == 0) {
>                 } else if (memcmp(str, "GART\n", 5) == 0) {
> 
> I am not sure if it is due to your patches or not.

Right, another stupid carelessness. Already sent a fix.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
