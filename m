From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Mon, 17 Sep 2007 18:38:53 -0700
Subject: My position on general ``RAS'' tool support infrastructure
In-Reply-To: <m1abrq7lbt.fsf@ebiederm.dsl.xmission.com>
References: <46E8B06D.9080006@bluelane.com>
	<m1abrq7lbt.fsf@ebiederm.dsl.xmission.com>
Message-ID: <20070917183853.42f29393.randy.dunlap@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, 13 Sep 2007 07:21:10 -0600 Eric W. Biederman wrote:

> Pete/Piet Delaney <pete@bluelane.com> writes:
> 
> > Jason, Eric:
> >
> > Did you read Keith Owens suggestion on RAS tools from:


Yes.  and I re-read it.

There are several things in Keith's email that make sense:

a.  all RAS tools should use a common interface
b.  it's not the kernel's job to decide which RAS tool runs first


Eric makes some good points too.  I'm mostly similar to Eric:
paranoid about trusting software/hardware after a panic (or oops).

So if someone wants to use multiple RAS tools on a panic event,
enabling an admin to set priorities is OK with me, but I'll only
trust the first one that is used, and even that one may have
problems.  IOW, I don't see a big need to support multiple RAS
tools at one time.  (speaking for myself)


> So if someone who is suggesting an implementation can absorb 
> and understand the requirements of the different groups and come
> up with solutions that meet the requirements of the different projects
> I think progress can be made.  That as far as I know takes talent.

Ack that.

---
~Randy

