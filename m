Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 20 Apr 2021 13:03:35 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC v2 1/6] fs: provide unlocked helper for freeze_super()
Message-ID: <20210420120335.GA3604224@infradead.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210417001026.23858-2-mcgrof@kernel.org>
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>

On Sat, Apr 17, 2021 at 12:10:21AM +0000, Luis Chamberlain wrote:
> freeze_super() holds a write lock, however we wish to also enable
> callers which already hold the write lock. To do this provide a helper
> and make freeze_super() use it. This way, all that freeze_super() does
> now is lock handling and active count management.

Can we take a step back and think about this a bit more?

freeze_super() has three callers:

 1) freeze_bdev
 2) ioctl_fsfreeze
 3) freeze_store (in gfs2)

The first gets its reference from get_active_super, and is the only
caller of get_active_super.  So IMHO we should just not drop the lock
in get_active_super and directly call the unlocked version.

The other two really should just call grab_super to get an active
reference and s_umount.

In other words: I don't think we need both variants, just move the
locking and s_active acquisition out of free_super.  Same for the
thaw side.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
