Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eztPP-00059p-E7
 for kexec@lists.infradead.org; Sun, 25 Mar 2018 00:21:16 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180324221849.GW14312@siri.cascardo.eti.br>
Date: Sat, 24 Mar 2018 19:17:18 -0500
In-Reply-To: <20180324221849.GW14312@siri.cascardo.eti.br> (Thadeu Lima de
 Souza Cascardo's message of "Sat, 24 Mar 2018 19:18:50 -0300")
Message-ID: <877eq1huup.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/2] cxgb4: collect hardware dump in second
 kernel
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
To: Thadeu Lima de Souza Cascardo <cascardo@debian.org>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, ganeshgr@chelsio.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, viro@zeniv.linux.org.uk

Thadeu Lima de Souza Cascardo <cascardo@debian.org> writes:

> On Sat, Mar 24, 2018 at 04:26:34PM +0530, Rahul Lakkireddy wrote:
>> Register callback to collect hardware/firmware dumps in second kernel
>> before hardware/firmware is initialized.  The dumps for each device
>> will be available under /sys/kernel/crashdd/cxgb4/ directory in second
>> kernel.
>> 
>> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
>> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
>> ---
>> v2:
>> - No Changes.
>> 
>> Changes since rfc v2:
>> - Update comments and commit message for sysfs change.
>> 
>> rfc v2:
>> - Updated dump registration to the new API in patch 1.
> [...]
>> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> index e880be8e3c45..265cb026f868 100644
>> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> @@ -5527,6 +5527,18 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  	if (err)
>>  		goto out_free_adapter;
>>  
>> +	if (is_kdump_kernel()) {
>> +		/* Collect hardware state and append to
>> +		 * /sys/kernel/crashdd/cxgb4/ directory
>> +		 */
>> +		err = cxgb4_cudbg_crashdd_add_dump(adapter);
>> +		if (err) {
>> +			dev_warn(adapter->pdev_dev,
>> +				 "Fail collecting crash device dump, err: %d. Continuing\n",
>> +				 err);
>> +			err = 0;
>> +		}
>> +	}
>>  
>
> The problem I see with this approach is that you require that the driver
> is built into the kdump kernel (or present as a module in the kdump
> initramfs), and that you will probe the device during the collection of
> the dumps.

Compared to doing something in a crashing kernel anything in the kdump
kernel is a walk in the park.  Nothing is trustable in a crashing
kernel.

> IMHO, if you are going to require the device to be probed by the same
> driver during kdump, you might just as well use the device object itself
> to present the crash data. I think that's what Stephen Hemminger meant
> when he said to use sysfs. No need at all for any special crashdd. Just
> add an attribute or attribute group to the device object.

Doing something with the device model might make sense.  I am not
certain it does.  It is quite possible the device is in such a weird
state that the device driver fails to initialize.  That doesn't
mean the device driver can't scrape the registers and present
meaningful information to the rest of the system.

Whatever you do with capturing the state needs to happen early before
the driver initializes and stomps on the relevant state.

I don't expect there is much for the driver model to do, unless we wish
to do something explicitly before the normal device probe methods
happen.  What we need is the infrastructure for catching what gets
read from the driver and placing it in the core dump.

> Otherwise, as Eric Biederman pointed out, you should just add that data
> into the vmcore before you kexec, so you don't even need to look at a
> different file, and the driver does not even need to be present in the
> kdump kernel.

No.  I do mean before a kexec on panic happens.  Doing anything with
gathering this kind of information before kexec on panic is a very very
very very bad idea that will almost certainly make crash dumps less
reliable.  Don't even think about doing extra work on the crash dump
path.  Not ever.  No.  No.  No.  No.

The reason we use kexec on panic instead just creating a core dump
in the kernel is that many have tried and no one has gotten the kernel
to create crash dumps when things go wrong and it matters.  Meanwhile
kexec on panic works more often than not.

I mean that /proc/vmcore is a device that is used to gather up the bits
of the crashing kernel and to present it in a format that is easy to
read/save.  The tools read /proc/vmcore.

The driver or whatever is gathering this information absolutely needs to
be in the kdump kernel.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
