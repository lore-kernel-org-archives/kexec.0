Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.active-venture.com ([67.228.131.205])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQlY5-0004K6-Ei
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 21:30:21 +0000
Date: Fri, 12 Apr 2013 14:30:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH] watchdog: Add hook for kicking in kdump path
Message-ID: <20130412213024.GA5812@roeck-us.net>
References: <20130408151509.GA20919@roeck-us.net>
 <20130409144431.GL79013@redhat.com>
 <20130409145228.GA1111@roeck-us.net>
 <20130409151423.GM79013@redhat.com>
 <20130409160757.GA27050@roeck-us.net>
 <20130410134039.GV79013@redhat.com>
 <20130410135123.GB15456@roeck-us.net>
 <20130410142055.GW79013@redhat.com>
 <20130410151041.GA6670@roeck-us.net>
 <20130412211627.GM79013@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130412211627.GM79013@redhat.com>
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
To: Don Zickus <dzickus@redhat.com>
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, wim@iguana.be, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Fri, Apr 12, 2013 at 05:16:27PM -0400, Don Zickus wrote:
> On Wed, Apr 10, 2013 at 08:10:41AM -0700, Guenter Roeck wrote:
> > > have no idea how to even find out if multiple watchdogs are open on the
> > > system.  Is there a list I could walk?  And with regard to 'watchdog is
> > 
> > /* the dev_t structure to store the dynamically allocated watchdog devices */
> > static dev_t watchdog_devt;
> > 
> > One way to look up the allocated watchdogs might be to loop through all kobj
> > instances for the major device using kobj_lookup. Don't know if there is a
> > better way.
> 
> Hmm, I got around to poking at this today and I am not sure kobj_lookup
> will work.  Besides being surrounded with another mutex, I don't have
> access to the character device domain to pass to kobj_lookup.
> 
> Perhaps I am not reading the code right, but I can't find a good way
> forward.
> 
> The only other hack I can think of, is to embed a list object in the
> watchdog structure and list_add each new register'd watchdog.  Then it
> would be trivial to walk the watchdog list.
> 
After looking into it again, I agree. Maybe you can give it a try. At least
other options look even more complicated (eg creating a watchdog class ?).

Guenter

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
