Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1465576876.3105.54.camel@infradead.org>
Subject: Re: [PATCH] arm64:kexec: Memstart should not be before the kernel
 start address
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 10 Jun 2016 09:41:16 -0700
In-Reply-To: <3624bf19-6569-b631-92f9-cc9fc91b40cd@codeaurora.org>
References: <1461708860-23034-1-git-send-email-sgoel@codeaurora.org>
 <1461715120.27026.4.camel@infradead.org>
 <3624bf19-6569-b631-92f9-cc9fc91b40cd@codeaurora.org>
Mime-Version: 1.0
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
To: "Goel, Sameer" <sgoel@codeaurora.org>, kexec@lists.infradead.org
Cc: timur@codeaurora.org, rruigrok@codeaurora.org, shankerd@codeaurora.org

Hi Sameer,

> > > On Tue, 2016-04-26 at 16:14 -0600, Sameer Goel wrote:
> > > > Starting 4.6-rc4 the kernel memblock start is rounded down to a desirable
> > > > alignment. So, the kernel can see reserved memory regions before the kernel
> > > > start address in the iomem query.
> > > > Need to make sure that the right kernel start address is picked from the iomem
> > > > query.
> > > > ---

It is still in question whether or not your's is the correct
fix.  Could you provide a test case that hits this problem
so we can work on the solution?

Thanks.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
