From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 25 May 2022 12:56:27 -0700
Subject: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
In-Reply-To: <877d6g0zxq.fsf@email.froward.int.ebiederm.org>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
	<87ee0q7b92.fsf@email.froward.int.ebiederm.org>
	<YoWySwbszfdZS9LU@MiWiFi-R3L-srv>
	<87bkvt4d56.fsf@email.froward.int.ebiederm.org>
	<20220520104641.GB194232@MiWiFi-R3L-srv>
	<877d6g0zxq.fsf@email.froward.int.ebiederm.org>
Message-ID: <20220525125627.acf27b28bb67417a6683a1d9@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, 20 May 2022 14:25:05 -0500 "Eric W. Biederman" <ebiederm@xmission.com> wrote:

> > I am not strongly against taking off __weak, just wondering if there's
> > chance to fix it in recordmcount, and the cost comparing with kernel fix;
> > except of this issue, any other weakness of __weak. Noticed Andrew has
> > picked this patch, as a witness of this moment, raise a tiny concern.
> 
> I just don't see what else we can realistically do.

I think converting all of the kexec __weaks to use the ifdef approach
makes sense, if only because kexec is now using two different styles.

But for now, I'll send Naveen's v2 patch in to Linus to get us out of
trouble.

I'm thinking that we should add cc:stable to that patch as well, to
reduce the amount of problems which people experience when using newer
binutils on older kernels?


