Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 7 Nov 2016 09:12:29 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] arm64: Add support for additional relocations in the
 kexec purgatory code
Message-ID: <20161107081229.GA13099@verge.net.au>
References: <1476960211-25594-1-git-send-email-catalin.marinas@arm.com>
 <2792b205-dfdd-1362-9cf4-d886472a9357@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2792b205-dfdd-1362-9cf4-d886472a9357@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, Oct 20, 2016 at 09:37:03AM -0700, Geoff Levand wrote:
> On 10/20/2016 03:43 AM, Catalin Marinas wrote:
> > When compiling the kexec-tools with gcc6, the following additional
> > reolcations are generated in the purgatory.ro file:
> > 
> > R_AARCH64_ADR_PREL_PG_HI21
> > R_AARCH64_ADD_ABS_LO12_NC
> > R_AARCH64_LDST64_ABS_LO12_NC
> 
> Looks good.  Simon, please apply.
> 
> Reviewed-by: Geoff Levand <geoff@infradead.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
