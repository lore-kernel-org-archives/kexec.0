Return-path: <kexec-bounces@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IbOEe-00016t-Lt
	for kexec@lists.infradead.org; Fri, 28 Sep 2007 23:23:03 +0100
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Kgdb-bugreport] Problem getting kgdb to read kernel symbols.
	addresses shifted?
References: <sjmabr8j6d7.fsf@pgpdev.ihtfp.org>
	<46FD03CD.9060404@windriver.com> <sjmve9uj3d2.fsf@pgpdev.ihtfp.org>
	<46FD1B6A.3000500@windriver.com>
	<20070928114522.n0cdrcebykkgg408@webmail.mit.edu>
	<46FD2CFB.9010404@windriver.com> <46FD75E1.3090602@bluelane.com>
Date: Fri, 28 Sep 2007 16:18:22 -0600
In-Reply-To: <46FD75E1.3090602@bluelane.com> (pete@bluelane.com's message of
	"Fri, 28 Sep 2007 14:45:05 -0700")
Message-ID: <m18x6qbfip.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: pete@bluelane.com
Cc: Derek Atkins <warlord@mit.edu>, kgdb-bugreport@lists.sourceforge.net, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@in.ibm.com>, Dave Anderson <anderson@redhat.com>, Jason Wessel <jason.wessel@windriver.com>

Pete/Piet Delaney <pete@bluelane.com> writes:

> Jason Wessel wrote:
>
> Shouldn't crash, kdump and kgdb take into consideration a
> shift in the kernel so that gdb works normally?
>
> Seems that having the kgdb stub knowledgeable of a shift
> in the kernel might be easy to compensate for. Perhaps
> just mapping all reads and writes that lie within the
> original kernel segments to the shifted addresses.

Good question.

I remember hearing some oddball reports about something like this.
My memory says what little tracking that happened pointed in
the direction of a confused gdb.

In particular unless you deliberately run a kernel at a different
address linux kernels should run at the addresses they were built
for so there should be nothing that has to be done.

I'm running on foggy memories so something may have changed
since last time I looked.

Eric


>
> -piet
>
>> Derek Atkins wrote:
>>> Quoting Jason Wessel <jason.wessel@windriver.com>:
>>>
>>>>> Um, okay.....  How do I do that?  My GDB Fu is weak here; how do I
>>>>> tell gdb that the symbols in vmlinux are all offset?  Or how do I
>>>>> manipulate the vmlinux binary to offset the symbols?
>>>>>
>>>> Start gdb with no file.  And do something like:  add-symbol-file vmlinux
>>>> 0xBFA00000
>>> Um, where did you get "0xBFA0000" from?  Unfortunately this didn't
>>> work at all.  I would think to get my numbers to work I'd need to
>>> use 0xC0400000 to get sys_close to appear at 0xc047d341.  And
>>> viola, that seems to work!  Or at least I got a reasonable breakpoint
>>> from the 'target remote'
>> 
>> It was an example.  You had previously stated it was an offset of
>> 0x600000 so it was a subtraction of 0x600000 from 0xc0000000.
>> 
>> Jaosn.
>> 
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by: Microsoft
>> Defy all challenges. Microsoft(R) Visual Studio 2005.
>> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>> _______________________________________________
>> Kgdb-bugreport mailing list
>> Kgdb-bugreport@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport
>> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
