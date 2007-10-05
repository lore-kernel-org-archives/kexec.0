Return-path: <kexec-bounces@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IdmhJ-0007e5-OW
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 13:54:31 +0100
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/2] add tunable_notifier function
References: <4704D0BA.4090507@ah.jp.nec.com>
Date: Fri, 05 Oct 2007 06:49:40 -0600
In-Reply-To: <4704D0BA.4090507@ah.jp.nec.com> (Takenori Nagano's message of
	"Thu, 04 Oct 2007 20:38:34 +0900")
Message-ID: <m1ir5llo9n.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Takenori Nagano <t-nagano@ah.jp.nec.com> writes:

> This patch adds new notifier function tunable_notifier_chain. Its base is
> atomic_notifier_chain.



> +/**
> + * tunable_notifier_chain_register - Add notifier to an tunable notifier chain
> + *	@nh: Pointer to head of the tunable notifier chain
> + *	@n: New entry in notifier chain
> + *	@name: Pointer to the name of this notifier chain
> + *	@desc: Pointer to the description of new entry
> + *
> + *	Adds a notifier to an tunable notifier chain and makes control dir.
> + *
> + *	Returns zero on success or %-ENODEV on failure.
> + */
> +
> +int tunable_notifier_chain_register(struct tunable_notifier_head *nh,
> +		struct tunable_notifier_block *n, char *name, char *desc)
> +{
> +	unsigned long flags;
> +	int ret = -EINVAL;
> +	struct dentry *nh_dir, *nb_dir, *pri_dentry, *desc_dentry = NULL;
> +
> +	if (!name)
> +		goto nb_fail;
> +
> +	ret = -ENOMEM;
> +	if (!nh->dir) {
> +		nh_dir = debugfs_create_dir(nh->name, NULL);

Hmm. debugfs does not appear to be an appropriate place to create
files that are supposed to be part of a serious user space interface.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
