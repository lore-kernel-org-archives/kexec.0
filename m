Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RQhlT-0000sO-R7
 for kexec@lists.infradead.org; Wed, 16 Nov 2011 15:51:14 +0000
Date: Wed, 16 Nov 2011 10:51:03 -0500
From: Don Zickus <dzickus@redhat.com>
Subject: Re: kexec-tools git tree is tagged incorrectly?
Message-ID: <20111116155103.GG8685@redhat.com>
References: <CAM_iQpW8J7hybZVVLK9rtoMrWbU4AS82ob0iNdbAMCxv8hpC-A@mail.gmail.com>
 <20111116011221.GA6216@verge.net.au>
 <CAM_iQpUVQ9tUcX7Bmc-E-bfxnODGK05KV=vcxHE9E34XS5QmNw@mail.gmail.com>
 <20111116023503.GA4468@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111116023503.GA4468@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org

On Wed, Nov 16, 2011 at 11:35:03AM +0900, Simon Horman wrote:
> On Wed, Nov 16, 2011 at 10:04:06AM +0800, Am=E9rico Wang wrote:
> > On Wed, Nov 16, 2011 at 9:12 AM, Simon Horman <horms@verge.net.au> wrot=
e:
> > >
> > > Hi Am=E9rico,
> > >
> > > I'm not sure that I understand your question, but
> > > 920f4ededd9627add3ca1cdea965d204f2ca43a7 is the HEAD of the master
> > > (development) branch. =A0And unless I am mistaken, it is a descendent=
 of v2.0.2.
> > >
> > =

> > Yeah, so `git describe HEAD` should show v2.0.2-BLAHBLAH, not
> > v1.101-618-g920f4ed, right?
> =

> Yes, I think so. I'm rather unsure why it isn't.
> However, the following does seem to give a result more in line with
> expectations.

Are you creating annotated tags or lightweight tags?  That might be the
difference.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
