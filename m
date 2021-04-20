Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYvOs-00CMDZ-T5
 for kexec@lists.infradead.org; Tue, 20 Apr 2021 18:47:11 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 em21-20020a17090b0155b029014e204a81e6so1745489pjb.1
 for <kexec@lists.infradead.org>; Tue, 20 Apr 2021 11:47:05 -0700 (PDT)
Date: Tue, 20 Apr 2021 18:47:03 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v2 6/6] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <20210420184703.GN4332@42.do-not-panic.com>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-7-mcgrof@kernel.org>
 <20210420125903.GC3604224@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420125903.GC3604224@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:59:03PM +0100, Christoph Hellwig wrote:
> > This also removes all the superflous freezer calls on all filesystems
> > as they are no longer needed as the VFS now performs filesystem
> > freezing/thaw if the filesystem has support for it. The filesystem
> > therefore is in charge of properly dealing with quiescing of the
> > filesystem through its callbacks.
> 
> Can you split that out from the main logic change?  Maybe even into one
> patch per file system?

The issue with this is that once you do the changes in pm to
freeze/suspend, if you leave the other changes in for the filesystems
freeze / resume will stall, so all this needs to be an atomic operation
if we want bisectable kernels.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
