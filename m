Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 25 Nov 2010 10:51:36 +0200
From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH v2] Add call to non-crashing cores through IPI
Message-ID: <20101125085136.GM14080@gw.healthdatacare.com>
References: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Per Fransson <per.xx.fransson@stericsson.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Nov 24, 2010 at 09:28:28AM +0100, Per Fransson wrote:
> v2 changes:
> * the interrupts of the calling core are no longer disabled
>   before performing the IPI

This version information should go after the commit message below
the '---' line.

> ---
> 
> When kexec is used to start a crash kernel the other cores
> are notified. These non-crashing cores will save their state
> in the crash notes and then do nothing.
> 
> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>

I tested this on UP machine (I don't have access to any SMP hardware) -
it didn't break anything and the crashdump works perfectly.

Regards,
MW

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
