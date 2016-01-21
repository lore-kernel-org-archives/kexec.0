Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMHQu-0004ZC-RT
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 15:46:01 +0000
From: Paul Moore <pmoore@redhat.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
Date: Thu, 21 Jan 2016 10:45:37 -0500
Message-ID: <5369666.tSqfcRVJfN@sifl>
In-Reply-To: <1453381932.9549.131.camel@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <20160121000300.GN11277@wotan.suse.de>
 <1453381932.9549.131.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: John Johansen <john.johansen@canonical.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thursday, January 21, 2016 08:12:12 AM Mimi Zohar wrote:
> Paul, Casey, Kees, Jon, Tetsuo does it make sense to consolidate the
> module, firmware, and kexec pre and post security hooks and have just
> one set of pre and post security kernel_read_file hook instead?   Does
> it make sense for this patch set to define the new hooks to allow the
> LSMs to migrate to it independently of each other?

Well, as usual, the easiest way to both get solid feedback and actually get a 
change accepted is to post patches to the affected LSMs.  Probably not what 
you wanted to hear, but at least I'm honest :)

-- 
paul moore
security @ redhat


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
