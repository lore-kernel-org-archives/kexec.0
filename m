Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1470079910.16559.49.camel@infradead.org>
Subject: Re: [PATCH] arm64:kexec: Memstart should not be before the kernel
 start address
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 01 Aug 2016 12:31:50 -0700
In-Reply-To: <569f36b7-e153-742f-b7fe-c3a1d7b1febc@codeaurora.org>
References: <1461708860-23034-1-git-send-email-sgoel@codeaurora.org>
 <1461715120.27026.4.camel@infradead.org>
 <3624bf19-6569-b631-92f9-cc9fc91b40cd@codeaurora.org>
 <1465576876.3105.54.camel@infradead.org>
 <569f36b7-e153-742f-b7fe-c3a1d7b1febc@codeaurora.org>
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
To: "Goel, Sameer" <sgoel@codeaurora.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: timur@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org, shankerd@codeaurora.org

Hi,

On Fri, 2016-07-29 at 16:58 -0600, Goel, Sameer wrote:
> In our setup we cannot place the kernel starting at 0 address. So, it it 
> placed at the first valid aligned address after placing the reserved 
> regions in memory.
> 
> The code from the change (https://patchwork.kernel.org/patch/8325221/) 
> adds the reserved regions to iomem ranges. So, when the kexec tool is 
> run it picks up the first reserved region as the start address for 
> physical ram. When the kernel is loaded at this address, it fails to boot.
> 
> So, I have put in a filter in the code that would pick up the right 
> address of the primary kernel after this change was introduced.
> Thanks,
> Sameer


Your patch no longer applies.  Please rebase it to my
for-merge-arm64-v2 branch and re-post.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
