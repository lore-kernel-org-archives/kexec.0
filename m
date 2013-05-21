Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UevQ5-0002Lo-4b
 for kexec@lists.infradead.org; Tue, 21 May 2013 22:52:37 +0000
Date: Tue, 21 May 2013 15:52:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH]Add kmsg_dump() to kexec path
Message-Id: <20130521155214.ecb11fad387da06eba3bb73b@linux-foundation.org>
In-Reply-To: <20130521224741.GA5707@kroah.com>
References: <A5ED84D3BB3A384992CBB9C77DEDA4D41AFEF289@USINDEM103.corp.hds.com>
 <20130521154137.0db53981578ee206b21850f9@linux-foundation.org>
 <20130521224741.GA5707@kroah.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "Luck, Tony (tony.luck@intel.com)" <tony.luck@intel.com>, "keescook@chromium.org" <keescook@chromium.org>, "kay@vrfy.org" <kay@vrfy.org>, "kexec-list (kexec@lists.infradead.org)" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>, Tomoki Sekiyama <tomoki.sekiyama@hds.com>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, Seiji Aguchi <seiji.aguchi@hds.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On Tue, 21 May 2013 15:47:41 -0700 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org> wrote:

> On Tue, May 21, 2013 at 03:41:37PM -0700, Andrew Morton wrote:
> > Guys, can we please get some review attention to this?
> 
> I thought it was reviewed, and rejected, already.  Did you miss those
> emails?

I had memories of the same thing, but can't find any record in lkml
archives.  Either we're thinking of a different patch or this one has
appeared under multiple titles.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
