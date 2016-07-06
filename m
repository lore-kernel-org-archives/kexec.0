Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1467827215.8880.44.camel@infradead.org>
Subject: Re: [PATCH v21 8/8] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 06 Jul 2016 10:46:55 -0700
In-Reply-To: <20160706075226.27609-9-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-9-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com
Cc: kexec@lists.infradead.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add documentation for linux,usable-memory and linux,elfcorehdr chosen
> nodes used by arm64 kexec to decribe the kdump reserved area, and the
> elfcorehdr's location within it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [akashi: wrap the commit description to avoid a checkpatch warning]
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Look OK.

Reviewed-by: Geoff Levand <geoff@infradead.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
