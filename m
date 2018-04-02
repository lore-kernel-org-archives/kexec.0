Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f2yTF-00032m-UR
 for kexec@lists.infradead.org; Mon, 02 Apr 2018 12:21:59 +0000
Date: Mon, 2 Apr 2018 14:21:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180402122140.GB8159@lunn.ch>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho>
 <20180330105156.GA24344@chelsio.com> <87k1tt2yo7.fsf@xmission.com>
 <20180402091143.GD3313@nanopsycho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180402091143.GD3313@nanopsycho>
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
To: Jiri Pirko <jiri@resnulli.us>
Cc: Indranil Choudhury <indranil@chelsio.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nirranjan Kirubaharan <nirranjan@chelsio.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, Ganesh GR <ganeshgr@chelsio.com>, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>

> >> The sysfs approach proposed here had been dropped in favour exporting
> >> the dumps as ELF notes in /proc/vmcore.
> >>
> >> Will be posting the new patches soon.
> >
> >The concern was actually how you identify which device that came from.
> >Where you read the identifier changes but sysfs or /proc/vmcore the
> >change remains valid.
> 
> Yeah. I still don't see how you link the dump and the device.

Hi Jiri

You can see in the third version the core code accept a free form
name. The driver builds a name using the driver name and the adaptor
name.

What i think would be good is to try to have one API to the driver
that can be used for both crash dumps and devlink snapshots. These are
used at different times, but have basically the same purpose, get
state from the device.

      Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
