Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.perches.com ([173.55.12.10])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Muro2-0003I6-CN
	for kexec@lists.infradead.org; Mon, 05 Oct 2009 17:57:10 +0000
Subject: Re: [PATCH 16/21] kernel/kexec.c: use pr_<level> and add pr_fmt(fmt)
From: Joe Perches <joe@perches.com>
In-Reply-To: <m163auvylv.fsf@fess.ebiederm.org>
References: <cover.1254701151.git.joe@perches.com>
	<cover.1254701151.git.joe@perches.com>
	<40ffa7c5595f4afbba793919b397b5139cde901a.1254701151.git.joe@perches.com>
	<m163auvylv.fsf@fess.ebiederm.org>
Date: Mon, 05 Oct 2009 10:57:02 -0700
Message-Id: <1254765422.1799.542.camel@Joe-Laptop.home>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, 2009-10-05 at 05:01 -0700, Eric W. Biederman wrote:
> Joe Perches <joe@perches.com> writes:
> > Added #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > Converted printk(KERN_<level> to pr_<level>(
> > Added KERN_ERR to allocation failure message
> I'm dense and I haven't seen the discussions.  What
> is the point of adding a prefix string where none exists
> into a bunch of printks?

Hi Eric.

There have been a few messages on lkml with little comment,
so I thought I'd get a few more by submitting some patches.

There is a [0/21] message that you might have received directly.
http://lkml.org/lkml/2009/10/4/198

I believe these are some of the +/-'s of each approach:
(copy/pasted from an earlier response)

Current:

o Allows some messages to not have a prefix at all
o Prefixes can vary inside a specific compilation unit

Proposed:

o Consistent, smaller source code, with no typos
  for instance: acpi/apic typos were found/fixed
                kernel/power had messages without PM:
                mce used "MCE: " and "mce: " prefixes
o Compatible with KMSG_COMPONENT
o All logging messages should have a prefix so
  it could be easier to grep/categorize logs
o Future:
  - Doesn't require each compilation unit to #define pr_fmt
  - Smaller objects without duplicated prefixes
  - Extensible via some dynamic_debug like mechanism
    to hide or show modname/__func__/offset without
    significant overhead or any increase in object size
    (printk would emit the prefix via some insertion
     mechanism after "<level>")



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
