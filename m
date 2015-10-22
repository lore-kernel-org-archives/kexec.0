Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1445474248.30908.115.camel@infradead.org>
Subject: Re: [PATCH] kexec: Add --lite option
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 21 Oct 2015 17:37:28 -0700
In-Reply-To: <5628279C.7030104@ozlabs.org>
References: <1445469125.30908.105.camel@infradead.org>
 <5628279C.7030104@ozlabs.org>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: kexec@lists.infradead.org, Anton Blanchard <anton@samba.org>, Petitboot@lists.ozlabs.org

Hi Jeremy,

On Thu, 2015-10-22 at 08:02 +0800, Jeremy Kerr wrote:
> Add a new option --lite to kexec that allows for a fast reboot
> > by avoiding the purgatory integrity checks.  This option is
> > intended for use by kexec based bootloaders that load a new
> > image and then immediately transfer control to it.
> 
> Can we call this something other than 'lite'? I'd want to prevent any
> confusion when referring to 'kexec-lite', which is a separate
> project.

Well, that is why I chose the name 'lite', because it mimics what kexec
-lite does...

What do others think?

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
