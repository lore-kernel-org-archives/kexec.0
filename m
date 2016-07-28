Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1469727192.16559.1.camel@infradead.org>
Subject: Re: [PATCH v2 3/4] arm64: Add arm64 kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 28 Jul 2016 10:33:12 -0700
In-Reply-To: <20160728041053.GB27150@localhost.localdomain>
References: <cover.1469559530.git.geoff@infradead.org>
 <fbb0f30aa1493b40c53264c9b5ae62b46606bd61.1469559530.git.geoff@infradead.org>
 <20160728041053.GB27150@localhost.localdomain>
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
To: Pratyush Anand <panand@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, 2016-07-28 at 09:40 +0530, Pratyush Anand wrote:
> On 26/07/2016:08:18:57 PM, Geoff Levand wrote:
> > Add kexec reboot support for ARM64 platforms.
> > 
> > Signed-off-by: Geoff Levand <geoff@infradead.org>
> > ---
> 
> [...]
> 
> > +
> > +#define OPT_APPEND		((OPT_MAX)+0)
> > +#define OPT_DTB			((OPT_MAX)+1)
> > +#define OPT_INITRD		((OPT_MAX)+2)
> > +#define OPT_REUSE_CMDLINE	((OPT_MAX)+4)
> 
> Option count 3 is missing. 

From the recently removed OPT_PORT.

Thanks for checking.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
